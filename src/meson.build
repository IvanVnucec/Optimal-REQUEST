# About: Meson build configuration for source directory.
# Author: Ivan Vnucec
# License: MIT

subdir('opt_req')

inc_dirs = ['opt_req']

srcs = ['main.c']

libs = []

if not meson.is_cross_build()
    libs += [opt_req]
    
    executable('demo',
        srcs, 
        link_with : libs, 
        include_directories : inc_dirs)
endif

