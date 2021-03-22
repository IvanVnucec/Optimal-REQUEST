# About: Meson build configuration for Unit tests.
# Author: Ivan Vnucec
# License WTFPL – Do What the Fuck You Want to Public License. See LICENSE.md file for more information.

cc = meson.get_compiler('c')

inc = ['./../src']

m_dep  = cc.find_library('m',  required : true)
rt_dep = cc.find_library('rt', required : true)

test_test = executable(
    'test_test', 
    sources:                ['test_test.c'], 
    include_directories:    [inc],
    c_args:                 [args], 
    dependencies:           [m_dep, rt_dep, matrix_math_dep]
)

test('test_test', test_test)
