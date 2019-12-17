subdir('elements')
subdir('simtools')

simulation_dep = declare_dependency(link_with: static_library(
	'simulation',
	sources: [
		files(
			'Air.cpp',
			'Element.cpp',
			'ElementClasses.cpp',
			'Gravity.cpp',
			'Particle.cpp',
			'SaveRenderer.cpp',
			'Sign.cpp',
			'SimTool.cpp',
			'SimulationData.cpp',
			'ToolClasses.cpp',
		),
		simulation_elem_files,
		simulation_tool_files,
	],
	dependencies: [
		project_dep,
		fftw_opt_dep,
	],
	include_directories: project_inc,
	cpp_args: project_cpp_arg,
))
