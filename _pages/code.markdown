
## PyEntropy
[PyEntropy](http://code.google.com/p/pyentropy/) is a Python library to implement calculation of entropy and information quantities using a range of bias correction methods. This contains the core information routines I use throughout my work, and was produced for eventual implementation as an online service in the CARMEN project. It also includes `pyentropy.maxent` - a module for computing maximum entropy solutions subject to marginal constraints over finite alphabet probability spaces using the information geometric methods of [Amari](http://www.brain.riken.jp/labs/mns/amari/home-E.html). It is an open source project hosted at Google code. See [Ince et al. (2009)](research.html#ince2009pfi) for details. The documentation, including a brief primer on entropy and information theory, is available [here](http://robince.github.com/pyentropy).

## FAMaxEnt
This module for computing finite alphabet maximum entropy solutions subject to marginal contraints is now distributed as part of the PyEntropy package (`pyentropy.maxent`).

## MATLAB/Python Integration
The Python programming language, together with the numerical libraries NumPy and SciPy, provides a compelling alternative to MATLAB for computational science. Here are some simple scripts to help copying and pasting [from MATLAB to Python](http://www.mathworks.com/matlabcentral/fileexchange/24087) and [from Python to MATLAB](http://codepad.org/MVYCM0AJ).

<!-- vim: set ts=2 sw=2 ft=mkd :-->
