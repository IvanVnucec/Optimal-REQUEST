# About: Meson build configuration for Unit tests.
# Author: Ivan Vnucec
# License: MIT

cc = meson.get_compiler('c')

inc = ['./../src']

m_dep  = cc.find_library('m',  required : true)
rt_dep = cc.find_library('rt', required : true)

test_test = executable(
    'test_test', 
    sources:                ['test_test.c'], 
    include_directories:    [inc],
    dependencies:           [m_dep, rt_dep]
)

test('test_test', test_test)
