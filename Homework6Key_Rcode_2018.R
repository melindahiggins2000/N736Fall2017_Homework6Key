# ==================================
# Homework 06 - logistic regression
# Answer Key
# 
# Melinda Higgins, PhD
# dated 12/01/2018
# ==================================

# ==================================
# we're be working with the 
# helpmkh dataset
# ==================================

library(tidyverse)
library(haven)

helpdat <- haven::read_spss("helpmkh.sav")

#' ============================================.
#' For the HELP dataset:
#' 
#' OUTCOME VARIABLE: 
#'  - consider the variable `e2b` "Number of times in past 6 
#' months entered a detox program - Baseline" 
#' - recode this into a new variable `nodetox` for those who did
#' NOT say they had entered a detox program 6mo prior to 
#' baseline and those who did 1 or more times (i.e. code 
#' the `e2b` missing as 1 and non-missing as 0 - 
#' see codes below to help you get started)
#' * PREDICTOR VARIABLE: consider these variables 
#' as potential predictors for `nodetox`:
#'  - `age`, `female`, `pss_fr`, `pcs`, `mcs`, and `cesd`
#' ============================================.

# ============================================
# For this homework we'll use the helpmkh dataset
#
# You will be working with the e2b variable
# Number of times in past 6 months entered a 
# detox program (collected at Baseline)
#
# For this logistic regression homework 6,
# I've provided the code below to capture the
# individuals who did NOT say they had entered a detox
# program in the 6 months preceeding baseline
# ============================================

helpdat$nodetox <- is.na(helpdat$e2b)

# check results - there are 239 NA's or missing values
# for e2b - these should now be 0's for nodetox
summary(helpdat$e2b)
summary(helpdat$nodetox)

# another way to check using table
# to get a 2-way table
# and include NA's in output
# check that the NA's for e2b are TRUE's for nodetox
table(helpdat$e2b, helpdat$nodetox, useNA = "ifany")

# For this logistic regression homework, you will
# use nodetox as your main outcome variable
# which is a logic variables coded FALSE and TRUE. 
# R interprets FALSE as 0 and TRUE as 1. A
# logic class type variable works fine 
# as an outcome in logistic regression.

# We'll use logistic regression to predict
# whether someone in a detox program or not (nodetox)
# prior to baseline using these variables
# age, female, pss_fr, pcs, mcs, and cesd.
# ============================================

h1 <- helpdat %>%
  select(nodetox, age, female, pss_fr,
         pcs, mcs, cesd)

# Logistic Regression Model 1

m1 <- glm(nodetox ~ mcs, data = h1, family=binomial)
m1
summary(m1)

# get odds ratios and 95% confidence intervals of odds ratios
exp(coef(m1))
exp(confint(m1))

# (optional) put all output together in one table
df1 <- data.frame(summary(m1)[["coefficients"]],
                  exp(coef(m1)),
                  exp(confint(m1)))
names(df1) <- c("B","SEb","Z","p-value","Odds Ratio (OR)",
                "OR 95% CI LB","OR 95% CI UB")
df1

# plot of predicted probabilities by MCS scores

m1.predict <- predict(m1, newdata=h1,
                      type="response")
plot(h1$mcs, m1.predict,
     xlab = "MCS - Mental Component Score SF36",
     ylab = "Model Predicted Probability of Not Being in Detox",
     main = "Probability of Not Being in Detox - Predicted by MCS scores")
abline(h=0.5, col="red")
abline(v=28, col="red")

# confusion matrix of predicted probabilities
# using cutoff > 0.5

#confusion matrix
table(h1$nodetox, m1.predict > 0.5,
      dnn = c("No Detox","Model Prediction"))

# UPDATE - look at %'s of total, set
# prop.r and prop.c to FALSE

library(gmodels)
CrossTable(h1$nodetox, m1.predict > 0.5,
           prop.r = FALSE,
           prop.c = FALSE,
           prop.t = TRUE,
           dnn = c("No Detox","Model Prediction"))

# logistic regression model 2 - several predictors

m2 <- glm(nodetox ~ age + female + pss_fr + pcs + mcs +
            cesd, data=h1, family=binomial)
summary(m2)
exp(coef(m2))
exp(confint(m2))

# (optional table) combined output

df2 <- data.frame(summary(m2)[["coefficients"]],
                  exp(coef(m2)),
                  exp(confint(m2)))
names(df2) <- c("B","SEb","Z","p-value","Odds Ratio (OR)",
                "OR 95% CI LB","OR 95% CI UB")
df2

# confusion matrix / classification table
# for model predictions > 0.5

m2.predict <- predict(m2, newdata=h1,
                      type="response")

gmodels::CrossTable(h1$nodetox, m2.predict > 0.5,
                    prop.r = FALSE,
                    prop.c = FALSE,
                    prop.t = TRUE,
                    dnn = c("No Detox","Model Prediction"))

# Make ROC Curve Plot of Model 2

# see https://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/

# make an ROC curve for model m2
library(ROCR)
p <- predict(m2, newdata=h1, 
             type="response")
pr <- prediction(p, as.numeric(h1$nodetox))
prf <- performance(pr, measure = "tpr", 
                   x.measure = "fpr")
#plot(prf)
#abline(0, 1, col="red")

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
#auc

# UPDATE - add title to plot with AUC in title
plot(prf,
     main = paste("ROC Curve, AUC = ", round(auc, 3)))
abline(0, 1, col="red")

