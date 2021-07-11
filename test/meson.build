# About: Meson build configuration for test directory.
# Author: Ivan Vnucec
# License: MIT

includes = ['../src', '../src/opt_req']
libs = [opt_req]

test_example = executable(
    'test_example', 
    sources : ['test_example.c'])

test_compare_matlab_and_c = executable(
    'test_compare_matlab_and_c', 
    sources : ['test_compare_matlab_and_c.c', 'test_meas_data.c', 'helper.c'],
    link_with : libs,
    include_directories : includes)

test('test_example', test_example)
test('test_compare_matlab_and_c', test_compare_matlab_and_c)
