* ==================================
* Homework 06 - logistic regression
* Answer Key
* 
* Melinda Higgins, PhD
* dated 12/14/2018
* ==================================

* ==================================
* we're be working with the 
* helpmkh dataset
* ==================================;

* remember to CHANGE to the correct directory on your computer;
libname library 'C:\MyGithub\N736Fall2017_HELPdataset\' ;

* apply values;
proc format library = library ;
   value TREAT
      0 = 'usual care'  
      1 = 'HELP clinic' ;
   value FEMALE
      0 = 'Male'  
      1 = 'Female' ;
   value HOMELESS
      0 = 'no'  
      1 = 'yes' ;
   value G1B
      0 = 'no'  
      1 = 'yes' ;
   value F1A
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1B
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1C
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1D
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1E
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1F
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1G
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1H
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1I
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1J
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1K
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1L
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1M
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1N
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1O
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1P
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1Q
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1R
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1S
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value F1T
      0 = 'Not at all or less than 1 day'  
      1 = '1-2 days'  
      2 = '3-4 days'  
      3 = '5-7 days or nearly every day for 2 weeks' ;
   value SATREAT
      0 = 'no'  
      1 = 'yes' ;
   value DRINKSTATUS
      0 = 'no'  
      1 = 'yes' ;
   value ANYSUBSTATUS
      0 = 'no'  
      1 = 'yes' ;
   value LINKSTATUS
      0 = 'no'  
      1 = 'yes' ;

proc datasets library = library;
modify helpmkh / correctencoding="WLATIN1";
   format     treat TREAT.;
   format    female FEMALE.;
   format  homeless HOMELESS.;
   format       g1b G1B.;
   format       f1a F1A.;
   format       f1b F1B.;
   format       f1c F1C.;
   format       f1d F1D.;
   format       f1e F1E.;
   format       f1f F1F.;
   format       f1g F1G.;
   format       f1h F1H.;
   format       f1i F1I.;
   format       f1j F1J.;
   format       f1k F1K.;
   format       f1l F1L.;
   format       f1m F1M.;
   format       f1n F1N.;
   format       f1o F1O.;
   format       f1p F1P.;
   format       f1q F1Q.;
   format       f1r F1R.;
   format       f1s F1S.;
   format       f1t F1T.;
   format   satreat SATREAT.;
   format drinkstatus DRINKSTATUS.;
   format anysubstatus ANYSUBSTATUS.;
   format linkstatus LINKSTATUS.;
quit;

* make a copy to WORK;
data helpmkh;
  set library.helpmkh;
  run;

* ============================================
* For this homework using the helpmkh dataset,
* You will be working with the e2b variable
* Number of times in past 6 months entered a 
* detox program (collected at Baseline)
*
* For this logistic regression homework 6,
* I've provided the code below to capture the
* individuals who did NOT say they had entered a detox
* program in the 6 months preceeding baseline
*
* nodetox = 0 for individuals who did enter
  a detox program and nodetox = 1 for individuals
  who did NOT say they entered a detox program
* ============================================;

data help2;
  set helpmkh;
  nodetox = missing(e2b);
  run;

* check results - the amount of missing for e2b
  should equal the number of 1's for nodetox;
proc freq data=help2;
  tables e2b nodetox;
  run;

* alternatively you can use the / missing option
  to get a table showing missing values for the 2 variables;
proc freq data=help2;
  tables e2b * nodetox / missing;
  run;

* ============================================
* For homework 6 focus on nodetox as the main outcome variable
* which is dichotomous coded 0 and 1. We'll use
* logistic regression to look at predicting whether someone
* was in detox or not using these variables
* age, female, pss_fr, pcs, mcs, and cesd
* ============================================;

* ==============================================
  MODEL 1
  Consider the continuous variable mcs as a predictor for nodetox
  - run a logistic regression of the probability of not being in 
    a detox program prior to baseline (nodetox) given their 
    mental health scores (mcs)
  - make a plot of the the predicted probability of no detox 
    (nodetox) by the mental health scores (mcs)
  - what value of the mcs leads to a probability of not being 
    in a detox program => 0.5? (hint: use the plot you just made)
* ==============================================;

* logistic regression model
  with one predictor mcs for nodetox
  (optional) tables of classification
  results for various cutoff probabilities;

proc logistic data=help2 plots=roc;
  model nodetox = mcs / ctable pprob=(0.2 to 0.8 by 0.1);
  output out=m1 p=prob;
  run;

* ============================================
  using the saved probabilities
  make a plot against the indtot predictor

  REMEMBER SAS is Predicting the OPPOSITE
  outcome nodetox=0, so SAS is predicting
  the probability of being in detox
* ============================================;

proc gplot data = m1;
  plot prob*mcs;
run;

* ========================================
  OPTIONAL - use ref=FIRST to explicitly
  get SAS to model the correct outcome
  setting 0 as the reference category
  and 1 as the outcome category

  ref=LAST is the default setting

  Read more at 
  http://documentation.sas.com/?docsetId=statug&docsetTarget=statug_logistic_syntax22.htm&docsetVersion=15.1&locale=en
* ========================================;

proc logistic data=help2 plots=roc;
  model nodetox(ref=FIRST) = mcs / ctable pprob=(0.2 to 0.8 by 0.1);
  output out=m1 p=prob;
  run;

proc gplot data = m1;
  plot prob*mcs;
  run;

* ===================================================
  MODEL 2
  Run a logistic regression model for the probability of 
  not being in a detox program 6mo prior to baseline considering 
  all of these possible predictor variables: age, female, pss_fr, pcs, mcs, and cesd.
  - present the final model results (B, SE(of B), 
    p-values, Odds Ratios, and 95% confidence intervals 
    for the Odds Ratios)
  - write a few sentences describing your results including:
    - model fit (report the Area Under the Curve (AUC) and 
      include a ROC plot) 
    - discuss if you think this is a good model or not 
      for predicting not being in a detox program 6mo prior to baseline
  - model classification table results - remember to report the 
    threshold used for the classification table - you can change 
    it from 0.5 if you think a different threshold might work better
  - odds ratios for each significant predictor in the model 
    (“…for every 1 unit change in the predictor the odds of not 
    being in a detox program prior to baseline was x.xxx times higher/lower…”)
* ===================================================;

proc logistic data=help2 plots=roc;
  model nodetox = age female pss_fr pcs mcs cesd;
  run;

* optional - flip reference category 
  using ref=FIRST option and run again
  so that nodetox=1 is the outcome modeled;

proc logistic data=help2 plots=roc;
  model nodetox(ref=FIRST) = age female pss_fr pcs mcs cesd;
  run;
