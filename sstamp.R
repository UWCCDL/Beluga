library(tidyverse)
library(ggplot2)
library(ggthemes)
d <- read_csv("slimstampen_all_trials.csv",
              col_types = cols(
                subj = col_character(),
                item = col_double(),
                resp = col_character(),
                isCorrect = col_logical(),
                RT = col_double(),
                duration = col_double(),
                type = col_character(),
                trial = col_double(),
                time = col_double(),
                levDist = col_double(),
                rep = col_double(),
                alpha = col_double(),
                fixedRT = col_double(),
                estRT = col_double()
              ))

by_item <- d %>%
  select(subj, item, alpha) %>%
  group_by(subj, item) %>%
  summarize(alpha = mean(alpha))

ggplot(by_item, aes(x=alpha, col=subj)) +
  geom_histogram(binwidth=0.01) +
  facet_wrap(~subj) +
  theme_pander()

by_subj <- by_item %>%
  select(subj, item, alpha) %>%
  group_by(subj) %>%
  summarize(alpha = mean(alpha))

ggplot(by_subj, aes(x=alpha)) +
  geom_histogram(binwidth=0.01, col="white") +
  theme_pander()

ggplot(by_item, aes(x=alpha, col=alpha)) +
  geom_histogram(binwidth=0.025, fill="grey50", alpha=0.75, col="white") +
  facet_wrap(~subj) +
  xlab(expression(paste("Rate of Forgetting ", alpha))) +
  xlim(0.25, 0.55) +
  ylim(0,15) +
  ylab("Numer of Items") +
  geom_segment(data=by_subj, x=by_subj$alpha, y=0,
               xend=by_subj$alpha, yend=15,
               lty=1, lwd=0.75) +
  scale_color_viridis(option="plasma") +
  ggtitle("Beluga: Individual Items and RoF By Subject") +
  theme_pander()
