# ==================================
# Homework 06 - logistic regression
# Answer Key
# 
# Melinda Higgins, PhD
# dated 11/20/2017
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
# Let's focus on g1b as the main outcome variable
# 	Experienced serious thoughts of 
# suicide (last 30 days) - Baseline
# which is dichotomous coded 0 and 1. 

# We'll use logistic regression to look at predicting 
# whether someone had suicidal thoughts
# or not using these variables
# age, female, pss_fr, pcs, mcs, cesd and indtot

# initially just look at cesd as a continuous predictor

# Consider the continuous variable cesd as a predictor 
# for g1b run a logistic regression of the probability 
# of suicidal thoughts (g1b) given their depressive 
# symptoms scores (cesd) make a plot of the the 
# predicted probability of suicidal thoughts (g1b) 
# by the depressive symptoms scores (cesd)
# what value of the cesd leads to a probability 
# of suicidal thoughts => 0.5? 
# _(hint: use the plot you just made)_

# ============================================.

h1 <- helpdat %>%
  select(g1b, age, female, pss_fr,
         homeless, pcs, mcs, cesd, indtot)

# ============================================.
# logistic regression of cesd to predict
# the probability of g1b, suicidal thoughts
# we'll also SAVE the predicted probabilities
# and the predicted group membership
#
# ============================================;

m1 <- glm(g1b ~ cesd, data=h1,
          family=binomial)
m1
summary(m1)
coef(m1)
exp(coef(m1))

m1.predict <- predict(m1, newdata=h1,
                      type="response")

plot(h1$cesd, m1.predict)
lines(c(0,60),c(0.5,0.5),col="red")

#confusion matrix
table(h1$g1b, m1.predict > 0.5)

library(gmodels)
CrossTable(h1$g1b, m1.predict > 0.5)

# try some other thresholds and compare
CrossTable(h1$g1b, m1.predict > 0.2)
CrossTable(h1$g1b, m1.predict > 0.4)
CrossTable(h1$g1b, m1.predict > 0.6)
CrossTable(h1$g1b, m1.predict > 0.8)

# see https://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/

# make an ROC curve

library(ROCR)
p <- predict(m1, newdata=h1, 
             type="response")
pr <- prediction(p, as.numeric(h1$g1b))
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
lines(c(0,1),c(0,1),col="blue")

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

# run the logistic regression entering all
# variables at once
m2 <- glm(g1b ~ ., data=h1, family=binomial)
summary(m2)

# you could simply choose to keep the significant vars
# which is female, homeless, mcs and cesd

# OPTIONAL - NOT COVERED IN CLASS
# ==========================================
# stepwise variable selection using step()
m0 <- glm(g1b ~ 1, data=h1, family=binomial)
m1 <- glm(g1b ~ ., data=h1, family=binomial)
step(m0,scope=formula(m1),direction="forward",k=2) # AIC

library(MASS)
stepAIC(m0,scope=formula(m1),direction="forward",k=2) #AIC criterion
n <- 453 # get sample size
stepAIC(m0,scope=formula(m1),direction="forward",k=log(n)) #BIC criterion

# try both
stepAIC(m0,scope=formula(m1),direction="both",k=2) #AIC

# try bestglm package
# create Xy dataset
# X should contain the vars
# you want to select among
# and the last column should be y the outcome
X <- h1[,2:9]
y <- h1$g1b

library(bestglm)
Xy <- cbind(X,y)
out <- bestglm(Xy)
out

# bestglm uses the BIC criterion for selection
# by default, you can try other information 
# criterion also like AIC or CV (cross validation)
bestglm(Xy, IC="AIC")
bestglm(Xy, IC="CV")