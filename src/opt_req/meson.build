# About: Meson build configuration for opt_req directory.
# Author: Ivan Vnucec
# License: MIT

cc = meson.get_compiler('c')

m_dep = []
if not meson.is_cross_build()
    m_dep += cc.find_library('m', required : true)
endif

srcs = [
    'get_quat_from_K_data.c',
    'get_quat_from_K_data.h',
    'get_quat_from_K_initialize.c',
    'get_quat_from_K_initialize.c',
    'get_quat_from_K_terminate.c',
    'get_quat_from_K_terminate.c',
    'get_quat_from_K_types.h',
    'get_quat_from_K.c',
    'get_quat_from_K.h',
    'optimal_request_init.c',
    'optimal_request_init.h',
    'optimal_request.c',
    'optimal_request.h',
    'rtwtypes.h',
    'vecnorm.c',
    'vecnorm.h',
]

deps = [m_dep]

if not meson.is_cross_build()
    opt_req = static_library(
        'opt_req', 
        srcs,
        dependencies : deps,
        install : true)
else
    opt_req_cross = static_library(
        'opt_req_cross', 
        srcs,
        dependencies : deps,
        link_args : ['-lm'],
        install : true)
endif
