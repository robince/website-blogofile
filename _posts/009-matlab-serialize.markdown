---
categories: Code, Matlab
date: 2013/06/18 14:38:35
title: "Saving structures quickly with serialization"
---

In an [earlier post](/blog/2013/03/21/saving-large-files-efficiently-in-matlab/) I showed how to improve performance when saving large numerical arrays.

However, often when working with [FieldTrip](http://fieldtrip.fcdonders.nl/), which uses complex nested structures and cell arrays to represent data, it is not easy to convert these structures into contiguous arrays. [This](http://undocumentedmatlab.com/blog/improving-save-performance/) very detailed post on the UndocumentedMatlab blog suggested another approach - serializing the data structure and saving it as a single array of bytes.

This is easily implemented using a pair of undocumented Matlab functions: `getArrayFromByteStream()` and `getByteStreamFromArray()`. It suffers from the 2GB data limit (I think the internal undocumented mxSerialize function is 32bit), and these undocumented functions could be removed in a future version, but for now it offers a big performance improvement for saving FieldTrip data (see below), and unlike the serializing options on the FileExchange these seem to happily handle things like sparse matrices and function handles which appear in the FieldTrip structure.

$$code
>> block_data

block_data = 

           hdr: [1x1 struct]
         label: {234x1 cell}
       fsample: 508.6300
         trial: {1x1265 cell}
          time: {1x1265 cell}
     trialinfo: [1265x1 double]
           cfg: [1x1 struct]
    sampleinfo: [1265x2 double]

>> tic; save normalmatlab block_data; toc
Elapsed time is 93.099165 seconds.
>> tic; dat = load('normalmatlab'); toc
Elapsed time is 22.938477 seconds.
>> 
>> tic; block_data_ser = getByteStreamFromArray(block_data); savefast serialized_data block_data_ser; toc
Elapsed time is 6.423112 seconds.
>> tic; dat = load('serialized_data'); block_data_load = getArrayFromByteStream(dat.block_data_ser); toc
Elapsed time is 4.848649 seconds.
>> block_data_load

block_data_load = 

           hdr: [1x1 struct]
         label: {234x1 cell}
       fsample: 508.6300
         trial: {1x1265 cell}
          time: {1x1265 cell}
     trialinfo: [1265x1 double]
           cfg: [1x1 struct]
    sampleinfo: [1265x2 double]

$$/code

This is just a quick timing without worrying about the filesystem cache, but I think it's clear that this method avoids much of the overhead of saving the nested structure. 

