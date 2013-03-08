---
categories: Code
date: 2013/03/08 12:45:17
title: "Intel Fortran with MATLAB"
---

It seems that in recent versions of Matlab (from at least R2012a), some cleanup was performed on the `fintrf.h` header file for the Fortran interface. 

Where the check for 64 bit platforms is performed, what used to be (R2011a) 

$$code(lang=c)
#if defined(__x86_64__) || defined(_M_AMD64) || defined(__amd64) || \
    defined(__sparcv9)  || defined(__ppc64__)
# define mwpointer integer*8
# define mwPointer integer*8
# define MWPOINTER INTEGER*8
#else
# define mwpointer integer*4
# define mwPointer integer*4
# define MWPOINTER INTEGER*4
#endif
$$/code

has been changed to 

$$code(lang=c)
#if defined(__LP64__) || defined(_M_AMD64) || defined(__amd64)
$$/code

Unfortunately, Intel Fortran (v12 at least) doesn't seem to define the `__LP64__` macro, so to get it to work I had to put the `__x86_64__` test back:

$$code(lang=c)
#if defined(__x86_64__) || defined(__LP64__) || defined(_M_AMD64) || \ 
    defined(__amd64) 
$$/code

This was on a Mac, but I think it would be the same on Linux.
