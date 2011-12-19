---
categories: code
date: 2011/12/19 18:39:58
title: "Nerdy thought for the day : cache hash collisions"
---

Saw this interesting [StackOverflow question](http://stackoverflow.com/questions/8547778/why-is-one-loop-so-much-slower-than-two-loops) linked on [reddit](http://www.reddit.com) this morning. 

I thought I had a bit of a handle on cache use after reading [Using OpenMP](http://www.amazon.com/Using-OpenMP-Programming-Engineering-Computation/dp/0262533022) but I must admit I had trouble understanding the answer.
This great [comment](http://www.reddit.com/r/programming/comments/nhl2j/why_is_one_loop_so_much_slower_than_two_loops/c3988cr) really bought it home for me:

> Caches are hash tables, using very simple hashing. Each memory address is
> mapped to specific bucket. Something like bucket[address % 16];
> 
> Due to uniform hashing there exists a pathological worst case access pattern
> which ensures that cache collision occurs on every access, forcing CPU to
> either try to find a different bucket or to force a cache miss.
>
> OS allocates memory in 4k chunks. When requesting a large allocation, arrays
> begin at a fresh page, so they are effectively aligned at same offset and same
> index always maps to same bucket in cache.
> 
> By allocating only a single array, same index maps to different buckets, since
> individual arrays are no longer aligned in same way.

Something to keep in mind - I often allocate several arrays of the same type and loop over them doing simple operations (entropy calculations etc.). 

