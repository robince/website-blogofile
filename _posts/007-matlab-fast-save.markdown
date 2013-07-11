---
categories: Code, Matlab
date: 2013/03/21 12:53:21
title: "Saving large files efficiently in Matlab"
---

You might have thought functionality as basic as saving numerical data to a file would be something you wouldn't have to worry too much about with a product as mature as [MATLAB](http://www.mathworks.co.uk/products/matlab/)... You'd be wrong!

### Matlab file formats

The standard MATLAB [file formats](http://www.mathworks.co.uk/help/matlab/ref/save.html) have evolved a bit over the years. Here are the main ones to give some background:

- `'-v4'` : The original binary format. Supports only 2D double, character and sparse arrays.
- `'-v6'` : adds N-d arrays, cell arrays, structures (R8 and later)
- `'-v7'` : adds compression and unicode (R14 and later)
- `'-v7.3'` : Supports data items larger than 2GB. This version is a complete break from the proprietary format and is instead based on [HDF5](http://en.wikipedia.org/wiki/Hierarchical_Data_Format). 

I believe `'v7'` remains the out of the box default in recent versions of Matlab.

`v7.3` also has the advantage that it allows easy memory mapping of files with the built in [`matfile`](http://www.mathworks.co.uk/help/matlab/ref/matfile.html) function.

### Performance problems

All the formats are slower to save complicated nested data structures (consisting of many cells and structure arrays) - although `v7.3` format suffers much more from this. `v7.3` can be orders of magnitude slower than `v7` for complex data, and there is also a large space overhead which can result in files many times larger for the same data. But in this post I want to focus on saving large plain numeric arrays. 

I am pretty sure I remember being able to control compression for the `v7` format in older versions, being able to turn it off with a flag (`-nocompression`?). However, in recent versions this is no longer possible, either for `v7` or the newer `v7.3` format. Some tedious trial and error (a manual binary search!) with [HDFView](http://www.hdfgroup.org/hdf-java-html/hdfview/) revealed that the threshold is 10,000 bytes - variables greater than this will be compressed, variables smaller will not be. 

For a couple of versions there was a [bizarre](http://stackoverflow.com/questions/4949939/matlab-saving-several-variables-to-v7-3-hdf5-mat-files-seems-to-be-faster) [bug](http://www.mathworks.co.uk/support/bugreports/784028) whereby only the first variable was compressed, while variables added later with the `-append` flag would not be. This provided a trick to allow saving uncompressed variables. However, since it is fixed in R2012a this workaround is no longer possible. Of course, it is possible to save directly to uncompressed HDF5 yourself with [h5create](http://www.mathworks.co.uk/help/matlab/ref/h5create.html) and [h5write](http://www.mathworks.co.uk/help/matlab/ref/h5write.html), but it is a bit more complicated and you lose some of the advantages of the standard format (easy interoperability with other users, memory mapping with `matfile` without needed another external tool). 

I was just about to write a little convenience wrapper to take care of creating HDF5 datasets from MATLAB variables when I searched the file exchange and found [savefast](http://www.mathworks.co.uk/matlabcentral/fileexchange/39721-save-mat-files-more-quickly), a recent contribution by Tim Holy. This uses a really nice trick of using `save` to create a `v7.3` file with a dummy variable, which puts in place all the MATLAB specific headers and metadata, and then simply writing numeric HDF5 datasets to this file (non-numeric variables are also written in the normal way with `save`). Evidently the additional properties `v7.3` puts on plain data arrays are not required since MATLAB loads the resulting files quite happily. Using this it is possible to save uncompressed numerical data easily to `v7.3` files, which means any other user can easily load them, use `matfile` etc. 

The timings below illustrate the effect. This is a fairly standard dataset (in this case [MEG](http://en.wikipedia.org/wiki/Magnetoencephalography) data) - a 3D double array of size 4574x560x232. This is around 4.5GB of data so the only builtin MATLAB option is `-v7.3`. 

### Writing

For testing the write speed I disabled the filesystem write cache to allow a fair comparison (mount with `-o sync` on linux). 

$$code
>> tic; save -v7.3 test73 dat; toc
Elapsed time is 985.465261 seconds.

>> tic; savefast testsf dat; toc
Elapsed time is 118.704114 seconds.

[robini@robini2-pc BON02]$ ls -lth test*
-rw-r--r-- 1 robini wheel 4.3G Mar 21 13:23 test73.mat
-rw-r--r-- 1 robini wheel 4.5G Mar 21 13:07 testsf.mat
$$/code

So writing compressed is more than 8 times slower, and the compression does not perform very well anyway (~5%). 

With the write cache enabled (if you trust your OS) the results are even more striking:

$$code
>> tic; save -v7.3 test73 dat; toc
Elapsed time is 234.201458 seconds.

>> tic; savefast testsf dat; toc
Elapsed time is 3.852583 seconds.
$$/code

Of course this is slightly misleading as the data is not really on disk yet, but if you trust your OS to take care of it sensibly then you can at least get on with work in the mean time. 

### Reading

Perhaps more important is the read speed - I usually read a dataset more times than I write it. Below are the read times for the two files above. There are two times for each file, the first is the *cold* time with read cache [empty](http://kassoulet.blogspot.co.uk/2007/12/how-to-clear-disk-cache-in-linux.html), the second is the *warm* time, which is when the data is already in memory.

$$code
>> tic; load testsf; toc
Elapsed time is 12.217814 seconds.
>> tic; load testsf; toc
Elapsed time is 1.751327 seconds.

>> tic; load test73; toc
Elapsed time is 43.092770 seconds.
>> tic; load test73; toc
Elapsed time is 41.348445 seconds.
$$/code

So in the case of a warm load, for example if local workers were accesses a large data set from disk to save serialisation) or just repeatedly running analysis scripts during a days work, the compressed standard file takes over 20 times longer to load.  

### Conclusion

- Try to save large data sets as homogenous numerical arrays rather than more complicated nested Matlab data types (cells, structures etc.).
- Use [`savefast`](http://www.mathworks.co.uk/matlabcentral/fileexchange/39721-save-mat-files-more-quickly)!
- If you have complicated data structures but they are smaller than 2GB then try `v7` and `v6`.

### Updates (July 2013)

- I have another post about how to more quickly save more intricate data structures (nested structures / cell arrays etc.) [using serialization](/blog/2013/06/18/saving-structures-quickly-with-serialization/).
- `savefast` doesn't work inside `parfor` loops due to the use of `evalin`. [savefaststruct](https://gist.github.com/robince/5974172) includes a minor change to allow `save -struct` style saving, which works inside parallel sections.
