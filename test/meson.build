# About: Meson build configuration for test directory.
# Author: Ivan Vnucec
# License: MIT

includes = ['../src', '../src/opt_req']
libs = [opt_req]

test_example = executable(
    'test_example', 
    sources : ['test_example.c'])

test_optimal_request_on_data = executable(
    'test_optimal_request_on_data', 
    sources : ['test_optimal_request_on_data.c', 'test_meas_data.c'],
    link_with : libs,
    include_directories : includes)

test('test_example', test_example)
test('test_optimal_request_on_data', test_optimal_request_on_data)
