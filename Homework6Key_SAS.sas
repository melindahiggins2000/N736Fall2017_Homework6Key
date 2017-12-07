
* make a copy to WORK;

data helpmkh;
  set library.helpmkh;
  run;

* Encoding: UTF-8.
* ============================================.
* Homework 6 Key - Logistic Regression
*
* Melinda Higgins, PhD
* dated 11/21/2017
* ============================================.

* ============================================.
* For this lesson we'll use the helpmkh dataset
*
* Let's focus on g1b as the main outcome variable
* which is dichotomous coded 0 and 1. We'll use
* logistic regression to look at predicting whether someone
* had suicidal thoughts or not using these variables
* age, gender, pss_fr, pcs, mcs, cesd and indtot and homeless
* ============================================.

* ============================================.
* Let's run a logistic regression of cesd to predict
* the probability of having g1b (suicidal thoughts)
* we'll also SAVE the predicted probabilities
* and the predicted group membership
*
* let's look at different thresholds pprob
* ctable gives us the classification table
*
* use the plots=roc to get the ROC curve
* ============================================;

* we can flip the g1b outcome in a data step
  or we can use the (event=last) option to change
  the reference category in SAS;

proc logistic data=helpmkh plots=roc;
  model g1b(event=last) = cesd / ctable pprob=(0.2 to 0.8 by 0.1);
  output out=m1 p=prob;
  run;

* ============================================
  using the saved probabilities
  make a plot against the indtot predictor
* ============================================;

proc gplot data = m1;
  plot prob*cesd;
run;

* ============================================
  let's also run using variable selection
* ============================================;

proc logistic data=helpmkh plots=roc;
  model g1b(event=last) = age female pss_fr homeless pcs mcs cesd indtot / 
    selection=forward ctable pprob=(0.2 to 0.8 by 0.1);
  run;
