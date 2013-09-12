---
categories: Code, Algorithms
date: 2013/09/12 11:29:42
title: "Fast quantization using quick select"
---

### Background

In my work I make heavy use of mutual information. 
One interpretation of mutual information is as (with a sample size dependent scale factor) the effect size for a [likelihood-ratio test of independence](http://en.wikipedia.org/wiki/G-test). 
This is similar to a [Chi-squared test of independence](http://en.wikipedia.org/wiki/Chi-squared_test); in fact the chi-squared test was developed by [Pearson](http://en.wikipedia.org/wiki/Karl_Pearson) as an approximation to avoid requiring the use of hard to compute logarithms.
Although mutual information can be calculated on continuous variables, the discrete case has the nicer statistical interpretations and is much faster to compute so I usually bin the continuous variables into discrete categories. 

The obvious way to bin is to divide the range of the variable into equal sections.
However, if the data are not uniformly distributed (e.g. Gaussian or similar) this can result in the edge bins having very low occupancy.
This makes the statistics worse, since the [bias](http://www.scholarpedia.org/article/Sampling_bias) is determined by the number of trials in each cell of the stimulus/response table.
A better way is to set the bins so that they are equally occupied - i.e. for 4 bins each bin represents a quartile.
While it might seem crude to represent a continuous variable with only 4 categories, I have found that binning in this way works remarkably well, especially with noisy data from electrophysiology and neuroimaging.
This is because quantile based binning makes the mutual information or G-test value into a rank statistic which is much more robust (and the reduction to some small number of quantiles rather than using the full rank of each trial only improves this). 

This equally occupied binning operation is something which I need to do a lot and became a bottleneck in the analysis.

### Partial sorting with quickselect

The obvious way to perform the equally-occupied binning procedure is to calculate the number of elements required in each bin, sort the full data set, then allocate the bins accordingly. 
After some profiling, it was clear that the main bottleneck was the full sort of the data.
However, a full sort isn't required - once the particular quantiles that divide the bins are obtained, all the elements between two bin edges get the same bin value, so they do not really need to be fully sorted.
After investigating some [sorting algorithms](http://en.wikipedia.org/wiki/Sorting_algorithm) I found that [quickselect](http://en.wikipedia.org/wiki/Quickselect) seemed to be the ideal algorithm for this jobs.
Quickselect is O(*n*), as opposed to O(*n*log*n*) for the full sort.
Although the algorithm needs to be repeated *m-1* times to obtain all the bin boundaries (where *m* is the number of bins), *m* is usually small (because of the limited amount of available data).

I found [this blog post](http://blog.teamleadnet.com/2012/07/quick-select-algorithm-find-kth-element.html) to have one of the most useful explanations of the algorithm and a nice implementation in Java, which I adapted to Fortran (see a future post for more details on why I am using Fortran).
My Fortran implementation can be found [here](https://gist.github.com/robince/6535436).
I use quickselect to partially sort the array while keeping a sorted index to the original array which I use to assign the appropriate output values.
I also implemented the bin allocation procedure for already sorted inputs; often I will need to do multiple quantisations of the same data (e.g. with different subsets of the data corresponding to different experimental conditions) - so in these cases it can be faster to fully sort the whole array once at the start.

### Addendum

The above does not work well if there are many repeated values in the data.
Although this is unusual in practise for data that is recorded from a noisy continuous system with a high quality ADC it is possible. 
One way to deal with this is to first extract the unique elements and then perform the above procedure, but since extracting unique values can be expensive it is often simpler to add a small amount of jitter to the data. 
