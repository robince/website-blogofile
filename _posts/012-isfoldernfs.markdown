---
categories: Code, Linux
date: 2015/03/13 12:49:49
title: "Checking that a Linux directory is a NFS mount point"
---

After a hard disk failure in the office I am setting up a more comprehesive backup system. 

The bulk of it consists of using [rsync](http://en.wikipedia.org/wiki/Rsync) to periodically synchronise data on my workstation with NFS mounts.

Each time I run rsync, I want to check that the destination directory is within a NFS mount point (so that I don't run out of space duplicating the data on my hard disk if the NFS destination directory is not mounted for some reason). Below is a little script which does this (I use it in a Makefile with a target for each project).

<script src="https://gist.github.com/robince/fde897e0bb46dbcdc5c4.js"></script>
