# ==================================
# Lesson 19 - logistic regression
# 
# Melinda Higgins, PhD
# dated 10/31/2017
# ==================================

# ==================================
# we're be working with the 
# helpmkh dataset
# ==================================

library(tidyverse)
library(haven)

helpdat <- haven::read_spss("helpmkh.sav")

# ============================================.
# For this lesson we'll use the helpmkh dataset
#
# Let's focus on homeless as the main outcome variable
# which is dichotomous coded 0 and 1. We'll use
# logistic regression to look at predicting whether someone
# was homeless or not using these variables
# age, female, pss_fr, pcs, mcs, cesd and indtot
# ============================================.

h1 <- helpdat %>%
  select(homeless, age, female, pss_fr,
         pcs, mcs, cesd, indtot)

# ============================================.
# let's look at the correlations between these variables
# ============================================;

# look at the correlation matrix
library(psych)
psych::corr.test(h1, method="pearson")

# ============================================.
# Given the stronger correlation between indtot
# and homeless, let's run a t-test to see the comparison
# ============================================;

# Bartlett Test of Homogeneity of Variances
bartlett.test(indtot~homeless, data=h1)

# t-tests, unequal variance and then equal variance
t.test(indtot ~ homeless, h1)
t.test(indtot ~ homeless, h1,
       var.equal=TRUE)

# ============================================.
# Let's run a logistic regression of indtot to predict
# the probability of being homeless
# we'll also SAVE the predicted probabilities
# and the predicted group membership
#
# let's look at different thresholds pprob
# ctable gives us the classification table
#
# use the plots=roc to get the ROC curve
# ============================================;

m1 <- glm(homeless ~ indtot, data=h1,
          family=binomial)

m1
summary(m1)
coef(m1)
exp(coef(m1))

m1.predict <- predict(m1, newdata=h1,
                      type="response")

plot(h1$indtot, m1.predict)

#confusion matrix
table(h1$homeless, m1.predict > 0.5)

library(gmodels)
CrossTable(h1$homeless, m1.predict > 0.5)

library(ROCR)
p <- predict(m1, newdata=h1, 
             type="response")
pr <- prediction(p, as.numeric(h1$homeless))
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

# =========================================
# UPDATES
# add stepwise variable selection approaches
# =========================================

# stepwise variable selection using step()
# from the stats package built into base R
m0 <- glm(homeless ~ 1, data=h1, family=binomial)
m1 <- glm(homeless ~ ., data=h1, family=binomial)
step(m0,scope=formula(m1),direction="forward",k=2) 
# with k=2 the AIC criterion is used
# which select variables indtot, pss_fr and age

# you can also use a better approach with the stepAIC
# function in the MASS package
library(MASS)
stepAIC(m0,scope=formula(m1),direction="forward",k=2) 
# AIC criterion, this is same results
# selects variables indtot, pss_fr and age

# we can also used the k=log(n) where n is the sample size
# to use the BIC criterion
n <- 453 # get sample size
stepAIC(m0,scope=formula(m1),direction="forward",k=log(n)) 
# BIC criterion - this selects only indtot and pss_fr

# try bestglm package
# create Xy dataset
# X should contain the vars
# you want to select among
# and the last column should be y the outcome
X <- h1[,2:8]
y <- h1$homeless

library(bestglm)
Xy <- cbind(X,y)
out <- bestglm(Xy)
out
# this selects pss_fr and indtot

# bestglm uses the BIC criterion for selection
# by default, you can try other information 
# criterion also like AIC or CV (cross validation)
bestglm(Xy, IC="AIC")
# CV runs a cross validation which takes 
# a few minutes to run
bestglm(Xy, IC="CV")


