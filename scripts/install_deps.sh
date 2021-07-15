#!/bin/bash

apt-get update

apt-get install -y \
python3-setuptools \
python3.8 \
python3-pip \
gcc-10 \
lcov \
gdb \
graphviz \
clang-format-11 \
octave \
cppcheck \
gcc-arm-none-eabi

pip3 install ninja meson
