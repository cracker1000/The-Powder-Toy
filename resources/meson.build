resources_src = []
if uopt_platform == 'windows'
	resources_src += windows_mod.compile_resources(
		'powder-res.rc',
		depend_files: files(
			'icon.ico',
			'document.ico',
			'../src/lua/luascripts/eventcompat.lua',
		),
	)
endif
