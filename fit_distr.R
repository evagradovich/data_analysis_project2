#load the library
library(fitdistrplus)
library(actuar)
library(MASS)

#plotdist(sleep_durations, histo = TRUE, demp = TRUE)
#fwei <- fitdist(sleep_durations, "weibull")
#summary(fexp)
#fexp <- fitdist(sleep_durations, "exp)
#if doesnt work try sleep_durations_scales <- (sleep_durations - min(sleep_durations) + 0.00001) / (max(sleep_durations) - min(sleep_durations) + 0.000002)
#summary(fit.exp)


#Making plots
#plot.legend <- c("Weibull", "Exponential")
#denscomp(list(fwei, fexp), legendtext = plot.legend)
#qqcomp(list(fwei, fexp), legendtext = plot.legend)
#cdfcomp(list(fwei, fexp), legendtext = plot.legend)

#initial plot

my_data <- x$duration #where x is dataframe split by wrapped_h

plot(my_data, pch=20)
plot(my_data, histo = TRUE, demp = TRUE)

descdist(my_data, discrete = TRUE, boot = 100) #helps decide potential distributions, not helpful most of the times

#fit log-normal, power law (pareto), exponential and Weibull (from research)

fit_ln <- fitdist(my_data, "lnorm", method="mle")
fit_e <- fitdist(my_data, "exp", method="mle")
fit_pl <- fitdist(my_data, "pareto", method="mle") # power law
fit_wei <- fitdist(my_data, "weibull", method="mle") #stretched exponential

#maximum likelihood (mle), moment matching (mme), quantile matching (qme) or maximizing goodness-of-fit estimation (mge). The latter is also known as minimizing distance estimation.
# (1) the
#parameter estimates, (2) the estimated standard errors (computed from the estimate of the Hessian matrix at the
#maximum likelihood solution), (3) the loglikelihood, (4) Akaike and Bayesian information criteria  (5) the correlation matrix between parameter estimates.

cdfcomp(list(fit_ln, fit_e, fit_pl, fit_wei), xlogscale = TRUE, ylogscale = TRUE, legendtext = c("lognormal", "exponential", "power law", "weibull"), lwd = 2)


#makes CDF log log plots of distribution fits

g <- gofstatlist(fit_ln, fit_e, fit_pl, fit_wei), fitnames = c("lognormal", "exponential", "power law", "weibull"))

#Goodness-of-fit statistics - that's what I really want to know
