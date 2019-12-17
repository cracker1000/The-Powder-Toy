project('the-powder-toy', [ 'c', 'cpp' ], version: '95.0.345', default_options: [
	'cpp_std=c++11'
])

cpp_compiler = meson.get_compiler('cpp')

conf_data = configuration_data()
conf_data.set('CURL_STATICLIB', false)
conf_data.set('ZLIB_WINAPI', false)

copt_x86 = host_machine.cpu_family() in [ 'x86_64', 'x86' ]
copt_64bit = host_machine.cpu_family() in [ 'x86_64', 'aarch64' ]

uopt_platform = get_option('system')
if uopt_platform == 'auto'
	if host_machine.system() in [ 'linux', 'freebsd' ]
		uopt_platform = 'linux'
	elif host_machine.system() in [ 'windows' ]
		uopt_platform = 'windows'
	elif host_machine.system() in [ 'darwin' ]
		uopt_platform = 'macosx'
	else
		error('unsupported platform: ' + host_machine.system())
	endif
endif

if uopt_platform == 'macosx'
	error('macosx is not yet supported')
endif
if uopt_platform == 'linux' and not copt_64bit
	error('lin32 is not yet supported')
endif
if uopt_platform == 'windows' and copt_64bit
	error('win64 is not yet supported')
endif

uopt_static = get_option('static')
use_tpt_libs = false
if uopt_static == 'system'
	if uopt_platform == 'windows'
		error('no way to find static system libraries on windows')
	endif
elif uopt_static == 'prebuilt'
	if uopt_platform == 'windows'
		use_tpt_libs = true
		tpt_libs = subproject('tpt-libs-prebuilt-win32-static')
	elif uopt_platform == 'linux'
		use_tpt_libs = true
		tpt_libs = subproject('tpt-libs-prebuilt-lin64-static')
	endif
else
	if uopt_platform == 'windows'
		use_tpt_libs = true
		tpt_libs = subproject('tpt-libs-prebuilt-win32-dynamic')
	endif
endif

uopt_native = get_option('native')
uopt_x86_sse = get_option('x86_sse')
if uopt_x86_sse == 'auto'
	uopt_x86_sse_level = 20
elif uopt_x86_sse == 'sse3'
	uopt_x86_sse_level = 30
elif uopt_x86_sse == 'sse2'
	uopt_x86_sse_level = 20
elif uopt_x86_sse == 'sse'
	uopt_x86_sse_level = 10
elif uopt_x86_sse == 'none'
	uopt_x86_sse_level = 0
endif
if not copt_x86 or uopt_native
	uopt_x86_sse_level = 0
endif

uopt_lua = get_option('lua')
if uopt_lua == 'luajit'
	lua_opt_dep = [ use_tpt_libs ? tpt_libs.get_variable('luajit_dep') : dependency('luajit', static: uopt_static == 'system') ]
elif uopt_lua == 'lua5.2'
	lua_opt_dep = [ use_tpt_libs ? tpt_libs.get_variable('lua52_dep') : dependency('lua5.2', static: uopt_static == 'system') ]
elif uopt_lua == 'lua5.1'
	lua_opt_dep = [ use_tpt_libs ? tpt_libs.get_variable('lua51_dep') : dependency('lua5.1', static: uopt_static == 'system') ]
else
	lua_opt_dep = []
endif

uopt_http = get_option('http')
if uopt_http
	curl_opt_dep = [ use_tpt_libs ? tpt_libs.get_variable('libcurl_dep') : dependency('libcurl', static: uopt_static == 'system') ]
else
	curl_opt_dep = []
endif

uopt_ignore_updates = get_option('ignore_updates')

uopt_fftw = get_option('gravfft')
if uopt_fftw
	fftw_opt_dep = [ use_tpt_libs ? tpt_libs.get_variable('fftw_dep') : dependency('fftw3f', static: uopt_static == 'system') ]
else
	fftw_opt_dep = []
endif

project_cpp_arg = []

if uopt_platform == 'linux'
	if uopt_x86_sse_level >= 30
		project_cpp_arg += '-msse3'
	endif
	if uopt_x86_sse_level >= 20
		project_cpp_arg += '-msse2'
	endif
	if uopt_x86_sse_level >= 10
		project_cpp_arg += '-msse'
	endif
	if uopt_native
		project_cpp_arg += '-march=native'
	endif
elif uopt_platform == 'windows'
	windows_mod = import('windows')
	if uopt_x86_sse_level >= 30
		message('SSE3 configured to be enabled but unavailable in MSVC')
		uopt_x86_sse_level = 20
	endif
	if uopt_native
		message('local machine optimization configured to be enabled but unavailable in MSVC')
		uopt_native = false
	endif
	if uopt_x86_sse_level >= 20
		project_cpp_arg += '/arch:SSE2'
	elif uopt_x86_sse_level >= 10
		project_cpp_arg += '/arch:SSE'
	endif
	if uopt_static != 'none'
		conf_data.set('CURL_STATICLIB', true)
		conf_data.set('ZLIB_WINAPI', true)
	else
		foreach input_and_output : tpt_libs.get_variable('config_dlls')
			configure_file(input: input_and_output[0], output: input_and_output[1], copy: true)
		endforeach
	endif
elif uopt_platform == 'macosx'
	error('macosx is not yet supported by this meson config')
endif
project_inc = include_directories([ '.', 'src', 'data', 'resources' ])
project_dep = [
	dependency('threads', static: uopt_static != 'none'),
	use_tpt_libs ? tpt_libs.get_variable('zlib_dep') : dependency('zlib', static: uopt_static == 'system'),
	lua_opt_dep,
	curl_opt_dep,
]
if uopt_platform == 'windows'
	project_dep += tpt_libs.get_variable('bz2_dep')
	project_dep += tpt_libs.get_variable('other_dep')
	project_dep += tpt_libs.get_variable('sdl2_dep')
	project_dep += tpt_libs.get_variable('sdl2main_dep')
else
	project_dep += use_tpt_libs ? tpt_libs.get_variable('bz2_dep') : cpp_compiler.find_library('bz2', static: uopt_static == 'system')
endif

conf_data.set('NOHTTP', not uopt_http)
conf_data.set('OGLI', false)
conf_data.set('OGLR', false)
conf_data.set('PIX32OGL', false)
conf_data.set('BETA', get_option('beta'))
conf_data.set('NO_INSTALL_CHECK', not get_option('install_check'))
conf_data.set('GRAVFFT', uopt_fftw)
conf_data.set('IGNORE_UPDATES', uopt_ignore_updates)
conf_data.set('LUACONSOLE', uopt_lua != 'none')
conf_data.set('LIN', uopt_platform == 'linux')
conf_data.set('WIN', uopt_platform == 'windows')
conf_data.set('MACOSX', uopt_platform == 'macosx')
conf_data.set('X86', copt_x86)
conf_data.set('X86_SSE3', uopt_x86_sse_level >= 30)
conf_data.set('X86_SSE2', uopt_x86_sse_level >= 20)
conf_data.set('X86_SSE', uopt_x86_sse_level >= 10)
conf_data.set('NATIVE', uopt_native)
conf_data.set('_64BIT', copt_64bit)
conf_data.set('SAVE_VERSION', get_option('version_major'))
conf_data.set('MINOR_VERSION', get_option('version_minor'))
conf_data.set('BUILD_NUM', get_option('version_build'))
conf_data.set('MOD_ID', get_option('mod_id'))
conf_data.set('DEBUG', get_option('debug'))
conf_data.set('SNAPSHOT', get_option('snapshot'))
conf_data.set('SNAPSHOT_ID', get_option('snapshot_id'))
conf_data.set('FUTURE_SAVE_VERSION', get_option('future_major'))
conf_data.set('FUTURE_MINOR_VERSION', get_option('future_minor'))
configure_file(
	input: 'src/Config.h.in',
	output: 'Config.h',
	configuration: conf_data
)

subdir('data')
subdir('resources')
subdir('src')

executable(
	'powder',
	sources: [
		data_files,
		powder_files,
		client_files,
		luaconsole_files,
		resources_src,
	],
	dependencies: [
		project_dep,
		graphics_dep,
		common_dep,
		simulation_dep,
		gui_dep,
	],
	include_directories: project_inc,
	cpp_args: project_cpp_arg,
	cpp_pch: 'pch/pch.h',
	gui_app: true
)

executable(
	'render',
	sources: [
		data_files,
		render_files,
	],
	dependencies: [
		project_dep,
		graphics_dep,
		common_dep,
		simulation_dep,
	],
	include_directories: project_inc,
	cpp_args: [
		project_cpp_arg,
		'-DRENDERER'
	],
	cpp_pch: 'pch/pch.h'
)

executable(
	'font',
	sources: [
		data_files,
		font_files,
	],
	dependencies: [
		project_dep,
		graphics_dep,
		common_dep,
		gui_dep,
	],
	include_directories: project_inc,
	cpp_args: [
		project_cpp_arg,
		'-DFONTEDITOR',
	],
	cpp_pch: 'pch/pch.h',
	gui_app: true
)

# [note 1]: these source files depend on the RENDERER and FONTEDITOR macros,
#           i.e. they behave differently based on which target is using them,
#           so they can't be part of the common static libraries
