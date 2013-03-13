---
categories: Code, Matlab
date: 2013/03/13 12:58:26
title: "Sharedmatrix with Parallel Computing Toolbox"
---

The [sharedmatrix](http://www.mathworks.co.uk/matlabcentral/fileexchange/28572-sharedmatrix) package allows the sharing of memory between Matlab sessions. It uses operating system shared memory and implements a proxy interface which allows you to use objects in this shared memory as if they were normal Matlab variables.

This is very useful, for example when using the Parallel Computing Toolbox with a local cluster profile on a multi-core workstation. You can put a large read-only dataset into shared memory, then attach to it on each iteration within a `parfor` loop. This avoids needing to load data from disk on each worker/iteration, or having to serialize all the data to send to each worker. It also avoids needing to keep multiple copies of the data in memory; recent versions of Matlab allow up to 12 workers in the local cluster - and keeping your data within `N / 13` where N is the amount of available RAM can be a bit restrictive.

On a local cluster it is quite straightforward to use since you can create the shared memory once, then attach to it within the loop since all the workers are running on the same physical machine. On a real cluster with many different nodes it is not so simple.

My solution is in the two files shown below. These scripts initialise the shared memory once per physical machine in the cluster so that all workers can then attach. 
 First you need to modify the `clonesharedmemory.m` function to load your useful data set and setup the shared memory copy. This needs to be done in a sub-function because of how scoping works inside the [`spmd`](http://www.mathworks.co.uk/help/distcomp/spmd.html) block.

<script src="https://gist.github.com/robince/5152382.js"></script>

With this setup you need to place the function somewhere that all the cluster workers will have access to (usually a network share), and also make sure all the workers have the `sharedmatrix` package on the Matlab path. The next script (using cell mode so you can run each step at a time) makes sure the above setup is run once per physical machine in the cluster. After this you can `attach` as required from any workers, for cheap read-only access to the large data set. 

<script src="https://gist.github.com/robince/5151962.js"></script>

The cluster I have access to runs on Linux, but I think this should also work on Windows (although I think the Windows version of sharedmatrix has a slightly different syntax).
