luaconsole_src_win = [
	'socket/wsocket.c',
]
luaconsole_src_nonwin = [
	'socket/unix.c',
	'socket/usocket.c',
]
luaconsole_src = [
	'CommandInterface.cpp',
	'LegacyLuaAPI.cpp',
	'LuaBit.cpp',
	'LuaButton.cpp',
	'LuaCheckbox.cpp',
	'LuaCompat.c',
	'LuaComponent.cpp',
	'LuaEvents.cpp',
	'LuaLabel.cpp',
	'LuaProgressBar.cpp',
	'LuaScriptInterface.cpp',
	'luascripts/eventcompat.lua.cpp',
	'LuaSlider.cpp',
	'LuaSmartRef.cpp',
	'LuaTextbox.cpp',
	'LuaWindow.cpp',
	'socket/auxiliar.c',
	'socket/buffer.c',
	'socket/except.c',
	'socket/inet.c',
	'socket/io.c',
	'socket/luasocket.c',
	'socket/options.c',
	'socket/select.c',
	'socket/socket.lua.cpp',
	'socket/tcp.c',
	'socket/timeout.c',
	'socket/udp.c',
	'TPTScriptInterface.cpp',
	'TPTSTypes.cpp',
]
if uopt_platform == 'windows'
	luaconsole_src += luaconsole_src_win
else
	luaconsole_src += luaconsole_src_nonwin
endif
luaconsole_files = files(luaconsole_src)
