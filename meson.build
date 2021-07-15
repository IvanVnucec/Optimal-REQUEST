# About: Project root Meson build configuration.
# Author: Ivan Vnucec
# License: MIT

project('optimal_request', 'c', default_options : ['c_std=c99', 'warning_level=3', 'werror=true'])

# Build project
subdir('src')

# Test project
if not meson.is_cross_build()
    subdir('test')
endif
