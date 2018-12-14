* Encoding: UTF-8.
* ==================================
* Homework 06 - logistic regression
* ANSWER KEY 2018
* 
* Melinda Higgins, PhD
* dated 12/14/2018
* ==================================

* ============================================
* For this homework we'll use the helpmkh dataset
*
* You will be working with the e2b variable
* Number of times in past 6 months entered a 
* detox program (collected at Baseline)
*
* For this logistic regression homework 6,
* I've provided the code below to capture the
* individuals who did NOT say they had entered a detox
* program in the 6 months preceeding baseline
* ============================================

* in SPSS use the MISSING() function to create
* a logical expression to capture the individuals
* who did NOT say they had entered a detox program
* prior to baseline. The TRUE's are coded 1 and 
* FALSE's are coded 0.

COMPUTE nodetox=MISSING(e2b).
EXECUTE.

* check the results using frequencies
* the number of system-missing for e2b
* should equal the number of 1's or TRUE's
* for the new variable nodetox.

FREQUENCIES VARIABLES=e2b nodetox
  /ORDER=ANALYSIS.

* MODEL 1
* Consider the continuous variable mcs as a predictor for nodetox
* run a logistic regression of the probability of not 
* being in a detox program prior to baseline (nodetox) 
* given their mental health scores (mcs)
* make a plot of the the predicted probability of no detox (nodetox) 
* by the mental health scores (mcs)
* what value of the mcs leads to a probability of not 
* being in a detox program => 0.5? (hint: use the 
* plot you just made).

* ============================================.
* Logistic regression of mcs to predict
* the probability of being nodetox (not being in detox)
* we'll also SAVE the predicted probabilities
* and the predicted group membership
*
* NOTE: The current default threshold cutoff is 0.5.
* ============================================.

LOGISTIC REGRESSION VARIABLES nodetox
  /METHOD=ENTER mcs 
  /SAVE=PRED PGROUP
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* ============================================.
* plot the predicted probability of nodetox
* against mcs to see the effect of mcs scores
* with the predicted probability
* ============================================.

GRAPH
  /SCATTERPLOT(BIVAR)=mcs WITH PRE_1
  /MISSING=LISTWISE.

* UPDATE - OPTIONAL for Homework 6 - Model 1
* The code below shows the ROC curve for the
* model results captured by PRE_1
* for the outcome nodetox (with an "event"
* defined as when nodetox=1).
* This will give you the AUC (area under the curve)
* for the model (albeit with 1 predictor, mcs here).
* The AUC's match since there is only 1 
* continuous predictor for this model.

ROC PRE_1 BY nodetox (1)
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
* This model with just indtot in it only had an AUC = .62 which is poor
* AUC 0.7-0.8 is fair
* AUC 0.8-0.9 is good
* AUC 0.9-1 is very good to excellent
* ============================================.

* ============================================.
* MODEL 2
* Run a logistic regression model for the probability 
* of not being in a detox program 6mo prior to baseline 
* considering all of these possible predictor variables: 
*   age, 
*   female, 
*   pss_fr, 
*   pcs, mcs, 
*   and cesd:
* Present the final model results (B, SE(of B), p-values, 
* Odds Ratios, and 95% confidence intervals for the Odds Ratios)
* write a few sentences describing your results including:
*   model fit (report the Area Under the Curve (AUC) and 
*   include a ROC plot) - 
*
* Discuss if you think this is a good model or 
* not for predicting not being in a detox program 6mo prior to baseline
* model classification table results - remember to report the 
* threshold used for the classification table - you can change 
* it from 0.5 if you think a different threshold might work better
* odds ratios for each significant predictor in the model 
* (“…for every 1 unit change in the predictor the odds of not 
* being in a detox program prior to baseline was x.xxx times 
* higher/lower…”)
*
* ============================================.

* (optional) check multicollinearity.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT nodetox
  /METHOD=ENTER age female pss_fr pcs mcs cesd.

* ============================================.
* put all variables together
* and run a multivariate logistic regression
* UPDATE add /SAVE=PRED PGROUP to save model fit results
* ============================================.

LOGISTIC REGRESSION VARIABLES nodetox
  /METHOD=ENTER age female pss_fr pcs mcs cesd 
  /SAVE=PRED PGROUP
  /PRINT=GOODFIT ITER(1) CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* UPDATE
* The code below shows the ROC curve for the
* model results captured by PRE_2
* for the outcome nodetox (with an "event"
* defined as when homeless=1).
* This will give you the AUC (area under the curve)
* for the model (now with 6 predictors).

ROC PRE_2 BY nodetox (1)
  /PLOT=CURVE(REFERENCE)
  /PRINT=SE COORDINATES
  /CRITERIA=CUTOFF(INCLUDE) TESTPOS(LARGE) DISTRIBUTION(FREE) CI(95)
  /MISSING=EXCLUDE.

