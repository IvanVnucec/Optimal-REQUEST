#!/bin/bash

apt-get update

apt-get install -y python3.8 \
python3-pip \
cppcheck \
gcc-10 \
lcov \
gdb \
graphviz \
clang-format-11 \
ninja-build \
octave

python3 -m pip install meson
