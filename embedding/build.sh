#!/bin/bash

~/mysoftwares/julia-0.7.0-beta2/share/julia/julia-config.jl \
--cflags --ldflags --ldlibs | xargs gcc $1

