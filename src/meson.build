# About: Meson build configuration for source directory.
# Author: Ivan Vnucec
# License: MIT

subdir('opt_req')

inc_dirs = ['opt_req']

srcs = ['main.c']

libs = [opt_req]

executable('demo',
    srcs, 
    link_with : libs, 
    include_directories : inc_dirs)

