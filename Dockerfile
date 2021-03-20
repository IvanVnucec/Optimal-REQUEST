# About: File to be used to build Docker image.
# Author: Ivan Vnucec
# License: Do whatever you want with it. I don't care.

FROM ubuntu:20.10

RUN apt-get update && \
    apt-get install -y python3.8 python3-pip cppcheck gcc-10 lcov gdb doxygen graphviz clang-format-11 ninja-build

RUN pip3 install --no-cache-dir meson

WORKDIR /app
