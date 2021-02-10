#!/usr/bin/env python
"""
This python script is a python version of lasso regression analysis based on A.S's Rmd

Author: Y.C. YANG
Date: 2-9-2021
Status: In progress
"""
from __future__ import division
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge
from sklearn.linear_model import Lasso
from sklearn.linear_model import LassoCV
from sklearn.linear_model import RidgeCV
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import KFold
import matplotlib.pyplot as plt
from sklearn.feature_extraction import DictVectorizer
import pandas as pd
import numpy as np
import json
import sklearn
import seaborn as sns

# load dataset
power2011 = pd.read_csv('../rsfmri/bin/power_2011.csv', usecols=["ROI", "X", "Y", "Z", "Network", "Color", "NetworkName"])
subj_full_dat = pd.read_csv("./subject_connectivity.csv", index_col=0)
dvs = pd.read_csv('../rsfmri/participants.tsv', delimiter='\t')
# define dependent variable
DV = 'MLAT5'  # define dependent variable(behavioral measurements) # DV = 'MLAT5' #MLAT5, alpha2, SymmetrySpan
# define network of interest (NOI)
NOI = [
        # "Uncertain",
        # "Sensory/somatomotor Hand",
        # "Sensory/somatomotor Mouth",
        "Cingulo-opercular Task Control",
        # "Auditory",
        "Default mode",
        "Memory retrieval?",
        "Ventral attention",
        # "Visual",
        "Fronto-parietal Task Control",
        # "Salience",
        "Subcortical",
        # "Cerebellar",
        "Dorsal attention"
]

def vectorize_mat(adj_matrix):
    """
    convert a NxN adjacency matrix to a Nx1 vector
    :param adj_matrix: NxN adjacency matrix
    :return: adjacency vector Nx1
    """
    vec = []
    for i, row in adj_matrix.iteritems():
        vec.extend(row.to_list())
    return np.array(vec)

def vectorize_mat_name(row_name_list, col_name_list):
    """
    convert NxN adjacency matrix name into a Nx1 column name
    :param row_name_list: a list of 264 connectivity id
    :param col_name_list: a list of 264 connectivity id
    :return: a Nx1 vector name
    """
    vec = []
    for r in row_name_list:
        for c in col_name_list:
            vec.append(json.dumps([r, c]))
    return np.array(vec)

def censor(vec_df, COI):
    """
    select a subset of connectivity vector
    :param vec_df: a Nx1 vector dataframe
    :param COI: connectivity of interests
    :return: a subset of connectivity vector
    """
    vec_df['censor'] = vec_df['connID'].apply(lambda x: json.loads(x)[0] < json.loads(x)[1])
    vec_df=vec_df.merge(COI, on=['netName'])
    return vec_df[vec_df['censor']==True]

def get_vector_df(NOI):
    """
    generate a connectivity vector df
    :return: connectivity vector df after censoring
    """
    # vectorize col
    col_vec = vectorize_mat_name(range(1,265), range(1,265))
    # vectorize network
    net_vec = vectorize_mat_name(power2011['Network'].to_list(), power2011['Network'].to_list())
    # vectorize network_name
    netname_vec = vectorize_mat_name(power2011['NetworkName'].to_list(), power2011['NetworkName'].to_list())
    # concate vector df
    vector_df = pd.DataFrame({'connID':col_vec, 'netID':net_vec, 'netName':netname_vec})

    COI=pd.DataFrame({'netName':vectorize_mat_name(NOI, NOI)})

    censored_df=censor(vector_df, COI)
    return censored_df

def get_subj_df(subj_full_dat, censored_df):
    """
    generate a subject df
    :return: a subject df
    """
    # comb into one big df
    # subs = []
    # for i in range(1, 65):
    #   vec_values = vectorize_mat(subjs[subjs['subID']==i].drop(['subID'], axis=1))
    #   subs.append(vec_values)
    #
    # df = pd.DataFrame(subs)
    # df.columns=col_vec
    # df.insert(0, "SymmetrySpan", dvs['SymmetrySpan'], True) # add dependent var

    # subj_full_dat = pd.read_csv("./full_dat.csv", index_col=0)
    subj_subdf = subj_full_dat[censored_df['connID'].to_list()].join(dvs[[DV]], how='left').dropna(how='any')
    return subj_subdf

def print_coefficients(model, features):
    """
    :param model:
    :param features:
    :return:
    """
    feats = list(zip(model.coef_, features))
    print(*feats, sep="\n")

def simple_linear_fit(train_data, test_data, features):
    """
    train the data with simple linear regression, print RMSE
    :param train_data:
    :param test_data:
    :param features:
    :return: rmse
    """
    linear_model = LinearRegression(fit_intercept=False)
    linear_model.fit(train_data[features], train_data[DV])
    test_pred = linear_model.predict(test_data[features])

    # calculate RMSE
    reg_RMSE = np.sqrt(mean_squared_error(test_data[DV], test_pred))
    print("rmse: ", round(reg_RMSE, 4))
    return linear_model

def ridge_fit(train_data, validation_data, features):
    """
    train the data with ridge regression, finding the best lamda
    :param train_data:
    :param test_data:
    :param features:
    :return: fit ridge dataframe with different lamda
    """
    ridge_data = []
    lams = np.logspace(-5, 5, 11)

    # loop through all L2
    for lam in lams:
       # Train the model and make predictions along all xs
        ridge_model = Ridge(alpha=lam, random_state=0, fit_intercept=False)
        ridge_model.fit(train_data[features], train_data[DV])
        ridge_train_pred = ridge_model.predict(train_data[features])
        train_rmse = np.sqrt(mean_squared_error(train_data[DV], ridge_train_pred))
        ridge_val_pred = ridge_model.predict(validation_data[features])
        validation_rmse = np.sqrt(mean_squared_error(validation_data[DV], ridge_val_pred))

        ridge_data.append({
          'l2_penalty': lam,
          'model': ridge_model,
          'train_rmse': train_rmse,
          'validation_rmse': validation_rmse
        })
    ridge_data = pd.DataFrame(ridge_data)
    return ridge_data

def plot_ridge_rmse(ridge_data):
    """
    plot the lamda vs. rmse for validation data to choose the best lamda
    :param ridge_data:
    :return:
    """
    # Plot the validation RMSE as a blue line with dots
    plt.plot(ridge_data['l2_penalty'], ridge_data['validation_rmse'],
           'b-o', label='Validation')

    # Plot the train RMSE as a red line dots
    plt.plot(ridge_data['l2_penalty'], ridge_data['train_rmse'],
           'r-o', label='Train')
    # Make the x-axis log scale for readability
    plt.xscale('log')
    # Label the axes and make a legend
    plt.xlabel('l2_penalty')
    plt.ylabel('RMSE')
    plt.legend()

def print_best_L2(ridge_data, test_data, features):
    """
    print best L2 and test_rmse
    :param ridge_data:
    :param test_data:
    :param features:
    :return:
    """
    best_ridge = ridge_data.loc[ridge_data['validation_rmse'].idxmin()]
    best_L2 = best_ridge['l2_penalty']
    ridge_test_pred = best_ridge.model.predict(test_data[features])
    test_rmse = round(np.sqrt(mean_squared_error(test_data[DV], ridge_test_pred)))
    print("Best L2: ", best_L2, "test_rmse: ", test_rmse)
    # print('------------------------')
    # print_coefficients(best_ridge.model, features)

def lasso_fit(train_data, validation_data, features):
    """
    train the data with lasso regression, finding the best lamda
    :return: fit lasso dataframe with different lamda
    """
    # init
    lasso_data = []
    lams = np.logspace(-10, 10, num=30)

    # loop through all L1
    for lam in lams:
      # Train the model and make predictions along all xs
        lasso_model = Lasso(alpha=lam, fit_intercept=False)
        lasso_model.fit(train_data[features], train_data[DV])
        lasso_train_pred = lasso_model.predict(train_data[features])
        train_rmse = np.sqrt(mean_squared_error(train_data[DV], lasso_train_pred))
        lasso_val_pred = lasso_model.predict(validation_data[features])
        validation_rmse = np.sqrt(mean_squared_error(validation_data[DV], lasso_val_pred))

        lasso_data.append({
          'l1_penalty': lam,
          'model': lasso_model,
          'train_rmse': train_rmse,
          'validation_rmse': validation_rmse
        })
    lasso_data = pd.DataFrame(lasso_data)
    return lasso_data

def plot_lasso_rmse(lasso_data):
    """
    plot the lamda vs. rmse for validation data to choose the best lamda
    :param lasso_data:
    :return:
    """
    # Plot the validation RMSE as a blue line with dots
    plt.plot(lasso_data['l1_penalty'], lasso_data['validation_rmse'],
             'b-o', label='Validation')
    # Plot the train RMSE as a red line dots
    plt.plot(lasso_data['l1_penalty'], lasso_data['train_rmse'],
             'r-o', label='Train')
    # Make the x-axis log scale for readability
    plt.xscale('log')
    # Label the axes and make a legend
    plt.xlabel('l1_penalty')
    plt.ylabel('RMSE')
    plt.legend()

def plot_lasso_tuning(lasso_data):
    alphas=[]
    coefs = []
    for i in range(len(lasso_data)):
        alphas.append(lasso_data['model'][i].alpha)
        coefs.append(lasso_data['model'][i].coef_)
    ax = plt.gca()
    ax.plot(alphas, coefs)
    ax.set_xscale('log')
    plt.axis('tight')
    plt.xlabel('alpha')
    plt.ylabel('weights')

def print_best_L1(lasso_data, test_data, features):
    """
    :param lasso_data: fitted lasso dataset
    :param test_data:
    :param features: 
    :return:
    """
    best_lasso = lasso_data.loc[lasso_data['validation_rmse'].idxmin()]
    best_L1 = best_lasso['l1_penalty']
    lasso_test_pred = best_lasso.model.predict(test_data[features])
    test_rmse = round(np.sqrt(mean_squared_error(test_data[DV], lasso_test_pred)))
    print("Best L1: ", best_L1, "test_rmse: ", test_rmse)

def plot_prediction(test_data, features, linear_model, best_ridge, best_lasso):
    """
    plot the predictions for best fit three models
    :param test_data:
    :param features:
    :param linear_model:
    :param best_ridge:
    :param best_lasso:
    :return:
    """
    test_data[DV+'_reg_pred'] = linear_model.predict(test_data[features])
    test_data[DV+'_ridge_pred'] = best_ridge.predict(test_data[features])
    test_data[DV+'_lasso_pred'] = best_lasso.predict(test_data[features])

    plt.plot(test_data.index, test_data[DV], 'ro', label = 'reg_observed')
    plt.plot(test_data.index, test_data[DV+'_reg_pred'], 'b^', label = 'reg_pred')
    plt.plot(test_data.index, test_data[DV+'_ridge_pred'], 'g*', label = 'ridge_pred')
    plt.plot(test_data.index, test_data[DV+'_lasso_pred'], 'yx', label = 'lasso_pred')

    plt.xlabel('subID')
    plt.ylabel(DV)
    plt.legend(loc='upper right')
    print('regular model: RMSE')
    print(np.sqrt(mean_squared_error(test_data[DV], test_data[DV+'_reg_pred'])))

    print('ridge model: RMSE')
    print(np.sqrt(mean_squared_error(test_data[DV], test_data[DV+'_ridge_pred'])))

    print('lasso model: RMSE')
    print(np.sqrt(mean_squared_error(test_data[DV], test_data[DV+'_lasso_pred'])))


###### LASSO FIT #######################################################################################################
def split_fit():
    censored_df = get_vector_df(NOI)        # filter useful region connections
    subj_subdf = get_subj_df(subj_full_dat, censored_df)

    # prepare dataset for fitting
    train_data, test_data = train_test_split(subj_subdf, test_size=0.2, random_state=1)  # train: 50
    validation_data, test_data = train_test_split(test_data, test_size=0.5, random_state=1)  # validationn:6, test:7
    features = list(train_data.columns)[:-1]

    # fit models
    linear_model = simple_linear_fit(train_data, test_data, features)

    ridge_data = ridge_fit(train_data, validation_data, features)
    # plot_ridge_rmse(ridge_data)
    print_best_L2(ridge_data, test_data, features)

    lasso_data = lasso_fit(train_data, validation_data, features)
    plot_lasso_rmse(lasso_data)
    plot_lasso_tuning(lasso_data)
    print_best_L1(lasso_data, test_data, features)

    # find best lamda
    best_ridge = ridge_data.loc[ridge_data['validation_rmse'].idxmin()]['model']
    best_lasso = lasso_data.loc[lasso_data['validation_rmse'].idxmin()]['model']

    # visualize fitting
    plot_prediction(train_data, features, linear_model, best_ridge, best_lasso)
    plot_prediction(validation_data, features, linear_model, best_ridge, best_lasso)
    plot_prediction(test_data, features, linear_model, best_ridge, best_lasso)

def cv_lasso_fit():
    censored_df = get_vector_df(NOI)  # filter useful region connections
    subj_subdf = get_subj_df(subj_full_dat, censored_df)

    # prepare dataset for fitting
    train_data, test_data = train_test_split(subj_subdf, test_size=0.2, random_state=1)  # train: 50
    features = list(train_data.columns)[:-1]

    # fit simple linear
    linear_model = simple_linear_fit(train_data, test_data, features)

    # fit lasso
    alphas = np.logspace(-5, 5, 10)
    lassocv = LassoCV(alphas=alphas, fit_intercept=False, max_iter=100000, cv=50, random_state=1, normalize=True)
    lassocv.fit(train_data[features], train_data[DV])

    lasso_model = Lasso(alpha=lassocv.alpha_, max_iter=10000, normalize=True)
    print("Alpha=", lassocv.alpha_) #alpha=0.2782559402207126
    lasso_model.fit(train_data[features], train_data[DV])
    print("mse = ", mean_squared_error(test_data[DV], lasso_model.predict(test_data[features]))) #46.52954556275525
    print("score = ", lasso_model.score(test_data[features], test_data[DV]))  # 0.003359543712846858
    print("best model coefficients:")
    pd.Series(lasso_model.coef_, index=features)

    # fit ridge
    alphas = np.logspace(-3, 3, 30)
    ridgecv = RidgeCV(alphas=alphas, cv=10, fit_intercept=False, normalize=True)
    ridgecv.fit(train_data[features], train_data[DV])
    print("Alpha=", ridgecv.alpha_)  # alpha=148.73521072935117

    ridge_model = Ridge(alpha=ridgecv.alpha_, normalize=True, fit_intercept=False)
    ridge_model.fit(train_data[features], train_data[DV])
    print("mse = ", mean_squared_error(test_data[DV], ridge_model.predict(test_data[features])))  # 48.97805483499447
    print("score = ", ridge_model.score(test_data[features], test_data[DV]))  # -0.04908634564183334
    print("best model coefficients:")
    pd.Series(ridge_model.coef_, index=features)

    # visualize fitting
    plot_prediction(train_data, features, linear_model, ridge_model, lasso_model)
    plot_prediction(test_data, features, linear_model, ridge_model, lasso_model)


def kfold_cv_lasso_fit():
    censored_df = get_vector_df(NOI)  # filter useful region connections
    subj_subdf = get_subj_df(subj_full_dat, censored_df)

    # prepare dataset for fitting
    train_data, test_data = train_test_split(subj_subdf, test_size=0.2, random_state=1)  # train: 50
    features = list(train_data.columns)[:-1]

    lasso_model = Lasso(random_state=1, max_iter=100000, fit_intercept=False, normalize=True)
    alphas = np.logspace(-4, -0.5, 30)
    tuned_parameters = [{'alpha': alphas}]
    n_folds = 5
    clf = GridSearchCV(lasso_model, tuned_parameters, cv=n_folds, refit=False)
    clf.fit(train_data[features], train_data[DV])

    lasso_model.set_params(alpha=clf.best_params_['alpha'])
    lasso_model.fit(train_data[features], train_data[DV])

    lasso_rmse = mean_squared_error(test_data[DV], lasso_model.predict(test_data[features]))
    print('best lasso rmse', round(lasso_rmse, 4))
    print_coefficients(lasso_model, features)

    scores = clf.cv_results_['mean_test_score']
    scores_std = clf.cv_results_['std_test_score']
    std_error = scores_std / np.sqrt(n_folds)

    plt.figure().set_size_inches(8, 6)
    plt.semilogx(alphas, scores)

    plt.semilogx(alphas, scores + std_error, 'b--')
    plt.semilogx(alphas, scores - std_error, 'b--')

    plt.fill_between(alphas, scores + std_error, scores - std_error, alpha=0.2)
    plt.ylabel('CV score +/- std error')
    plt.xlabel('alpha')
    plt.axhline(np.max(scores), linestyle='--', color='.5')
    plt.xlim([alphas[0], alphas[-1]])

##################################################### END ##############################################################
