# Data analysis project 2 - Exploratory analysis of sleep bouts distributions in Drosophila flies


Summary of the included scripts:
* **data_preprocessing.R** = script for data loading and initial pre-processing e.g. to remove individuals in which sleep deprivation was studied and animals that died during experiment (source of data omitted from the script for data protection purposes - unpublished data)
* **format_manipulation.R** = script for generating bouts from the data, separating males from females, sleep bouts from wake bouts etc. General useful file manipulation commands.
* **fit_distr.R** = fitting distributions onto the data using MLE for parameter estimation
* **3_parameter_weibull.R** = parameter estimation using MLE for 3-parameter Weibull distribution. Was attempted with a threshold parameter of 5 min to investigate the tail of sleep bout distribution.
