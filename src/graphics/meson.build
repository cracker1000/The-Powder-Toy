graphics_dep = declare_dependency(link_with: static_library(
	'graphics',
	sources: files(
		'Graphics.cpp',
		'OpenGLGraphics.cpp',
		'RasterGraphics.cpp',
		'../resampler/resampler.cpp',
	),
	dependencies: project_dep,
	include_directories: project_inc,
	cpp_args: project_cpp_arg,
))
