---
categories: Code, Matlab
date: 2013/04/18 16:39:52
title: "Fitting multivariate t-distributions to data"
---

I found that some of the [MEG](http://en.wikipedia.org/wiki/Magnetoencephalography) data I am working with has long tails which was causing some problems when using non-robust statistics that assume normality.
Visual inspection showed a t-distribution might be a good fit:

![Example fit 1](/img/goodch_alldata_fits.png)  ![Example fit 2](/img/badch_alldata_fits.png)

The figures show the histogram of the data, together with the probability density of the maximum likelihood normal (green) and t-distribution (magenta).

The Matlab function [`fitdist`](http://www.mathworks.co.uk/help/stats/fitdist.html) (in the statistics toolbox) supports a 1-d `'tlocationscale'` distribution but I couldn't find anything online for estimating the parametrs of a multidimensional t-distribution. 
I also wanted something with a more flexible approach to allow fitting mean and scale with a fixed degrees of freedom, fitting several groups with equal d.o.f. etc.

I wrote up some functions to do this using ECME (a variant of the [expectation-maximization algorithm](http://en.wikipedia.org/wiki/Expectation_maximization)) and put them on Github in case it might be useful to anyone else: [tdistfit](https://github.com/robince/tdistfit).

