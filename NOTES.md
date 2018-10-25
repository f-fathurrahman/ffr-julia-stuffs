# Base.summarysize

useful for getting allocated memory for an object.


# About using PyCall.

The first time I installed PyCall, it tried to install the required package Conda.
Conda by default will download Miniconda (which is quite large for me, despite
the name *Mini*).
Use
```
ENV["PYTHON"] = /usr/bin/python
```
or if using Anaconda:
```
ENV["PYTHON"] = /path/to/anaconda/python
```
Make sure that `PYTHON_PATH` is not set when using Anaconda.


# Jupyter notebook

Using jupyter notebook

```
export PYTHONPATH="/home/efefer/.julia/v0.5/Conda/deps/usr
```

EDIT: No longer necessary. I now use jupyter-notebook from Anaconda3.

# First encounter: 16 Dec 2015

First meeting with Julia, from blog

http://cyrille.rossant.net/

title: What's wrong with scientific Python?



