---
categories: Code, Algorithms, Matlab
date: 2013/09/12 15:20:32
title: "Rebinning discrete data into a smaller number of bins"
---

The previous post on [quantization](blog/2013/09/12/fast-quantization-using-quick-select/) dealt with binning a continuous variable into a small number of discrete categories.
But sometimes the source data is already discrete, for example when the data are counts (e.g. counts of spikes emitted by a neuron within a certain time window). 
Sometimes the raw counts can be high, so keeping the full discrete counts would mean the space was too big to sample properly (because of the [bias problem](http://www.scholarpedia.org/article/Sampling_bias)), or if counts with different ranges from different situations need to be compared, it can be better to reduce them to a common number of bins to allow a fairer comparison.
In these cases, it is required to rebin a discrete variable.
Due to the multiple repeated values the usual continuous binning is not ideal. 
It is possible to add jitter, but this is likely to result in discrete input categories being split. 

In general, it can be useful to take a discrete variable with `m` possible values (I usually assume integers in the range `[0, m-1]`) and rebin it to `l` bins (where `l<m`) subject to:

- data points with the same input value should have the same output value (don't split bins)
- numerical ordering should be preserved (i.e. if `x<y` in the input then the corresponding output values should be `<=`)
- subject to the above constraints the resulting new binning should be as uniform as possible

A simple heuristic approach to this problem is to iteratively merge the smallest (lowest occupancy) input bin to its smallest neighbour until the desired number of bins are achieved. My Matlab implementation of this can be found here: [`rebin.m`](https://gist.github.com/robince/6538295).

I am sure performance can be improved (looking back at it after some time I am sure I don't need to sort the counts every time, but could preserve the sorting when two bins are merged), but so far I haven't needed to do that.
