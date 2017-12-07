* Encoding: UTF-8.
* ============================================.
* Homework 6 Answer Key - Logistic Regression
*
* Melinda Higgins, PhD
* dated 11/21//2017
* ============================================.

* ============================================.
* For this homework we'll use the helpmkh dataset
*
* Let's focus on g1b as the main outcome variable (suicidal thoughts)
* which is dichotomous coded 0 and 1. We'll use
* logistic regression to look at predicting whether someone
* had suicidal thoughts or not using these variables
* age, gender, pss_fr, pcs, mcs, cesd and indtot and homeless
* ============================================.

* ============================================.
* Let's run a logistic regression of indtot to predict
* the probability of being homeless
* we'll also SAVE the predicted probabilities
* and the predicted group membership
*
* NOTE: The current default threshold cutoff is 0.5.
* ============================================.

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=ENTER cesd 
  /SAVE=PRED PGROUP
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* ============================================.
* plot the predicted probability of homeless
* against indtot to see the effect of indtot scores
* with the predicted probability
* ============================================.

GRAPH
  /SCATTERPLOT(BIVAR)=cesd WITH PRE_1
  /MISSING=LISTWISE.

* ============================================.
* let's look at some other threshold values
* and we'll compare the classification tables.
* ============================================.

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=ENTER cesd 
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.2).

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=ENTER cesd 
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.4).

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=ENTER cesd 
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.6).

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=ENTER cesd 
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.8).

* ============================================.
* another way to look at these tradeoofs is to run
* a ROC (receiver operating characteristic) curve
* let's look at one for indtot for homeless
* ============================================.

ROC cesd BY g1b (1)
  /PLOT=CURVE(REFERENCE)
  /PRINT=SE COORDINATES
  /CRITERIA=CUTOFF(INCLUDE) TESTPOS(LARGE) DISTRIBUTION(FREE) CI(95)
  /MISSING=EXCLUDE.

* ============================================.
* sensitivity is the TRUE positive rate - numer of correctly 
* identified positive cases
* selectivity is the TRUE negative rate - numer of correctly
* identified negatives cases
*
* AUC = area under the curve is a measure of how well that
* predictor or model did for classifying the outcome correctly
* This model with just indtot in it only had an AUC = .644 which is poor
* AUC 0.7-0.8 is fair
* AUC 0.8-0.9 is good
* AUC 0.9-1 is very good to excellent
* ============================================.

* ============================================.
* run using variable selection for g1b
* age, female, pss_fr, homeless, pcs, mcs, cesd, indtot
* ============================================.

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=FSTEP(LR) age female pss_fr homeless pcs mcs cesd indtot
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* look at a series of different thresholds

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=FSTEP(LR) age female pss_fr homeless pcs mcs cesd indtot
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.2).

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=FSTEP(LR) age female pss_fr homeless pcs mcs cesd indtot
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.4).

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=FSTEP(LR) age female pss_fr homeless pcs mcs cesd indtot
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.6).

LOGISTIC REGRESSION VARIABLES g1b
  /METHOD=FSTEP(LR) age female pss_fr homeless pcs mcs cesd indtot
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.8).


