powder_files = files(
	'debug/DebugLines.cpp',
	'debug/DebugParts.cpp',
	'debug/ElementPopulation.cpp',
	'debug/ParticleDebug.cpp',
	'gui/colourpicker/ColourPickerActivity.cpp',
	'gui/console/ConsoleController.cpp',
	'gui/console/ConsoleModel.cpp',
	'gui/console/ConsoleView.cpp',
	'gui/elementsearch/ElementSearchActivity.cpp',
	'gui/filebrowser/FileBrowserActivity.cpp',
	'gui/game/BitmapBrush.cpp',
	'gui/game/Brush.cpp',
	'gui/game/DecorationTool.cpp',
	'gui/game/Favorite.cpp',
	'gui/game/GameController.cpp',
	'gui/game/GameModel.cpp',
	'gui/game/GameView.cpp',
	'gui/game/Menu.cpp',
	'gui/game/PropertyTool.cpp',
	'gui/game/QuickOptions.cpp',
	'gui/game/SampleTool.cpp',
	'gui/game/SignTool.cpp',
	'gui/game/ToolButton.cpp',
	'gui/game/Tool.cpp',
	'gui/interface/AvatarButton.cpp',
	'gui/interface/CopyTextButton.cpp',
	'gui/interface/RichLabel.cpp',
	'gui/interface/SaveButton.cpp',
	'gui/localbrowser/LocalBrowserController.cpp',
	'gui/localbrowser/LocalBrowserModel.cpp',
	'gui/localbrowser/LocalBrowserView.cpp',
	'gui/login/LoginController.cpp',
	'gui/login/LoginModel.cpp',
	'gui/login/LoginView.cpp',
	'gui/options/OptionsController.cpp',
	'gui/options/OptionsModel.cpp',
	'gui/options/OptionsView.cpp',
	'gui/preview/PreviewController.cpp',
	'gui/preview/PreviewModel.cpp',
	'gui/preview/PreviewView.cpp',
	'gui/profile/ProfileActivity.cpp',
	'gui/render/RenderController.cpp',
	'gui/render/RenderModel.cpp',
	'gui/render/RenderView.cpp',
	'gui/save/LocalSaveActivity.cpp',
	'gui/save/ServerSaveActivity.cpp',
	'gui/search/SearchController.cpp',
	'gui/search/SearchModel.cpp',
	'gui/search/SearchView.cpp',
	'gui/tags/TagsController.cpp',
	'gui/tags/TagsModel.cpp',
	'gui/tags/TagsView.cpp',
	'gui/update/UpdateActivity.cpp',
	'powdertoyjava/OpenGLCanvasWin32.cpp',
	'powdertoyjava/PowderToyJava.cpp',
	'SDLCompat.cpp',
	'tasks/AbandonableTask.cpp',
	'tasks/Task.cpp',
	'tasks/TaskWindow.cpp',
	'Update.cpp',
	'graphics/Renderer.cpp', # see [note 1]
	'simulation/Simulation.cpp', # see [note 1]
	'client/Client.cpp', # see [note 1]
	'client/GameSave.cpp', # see [note 1]
	'PowderToySDL.cpp', # see [note 1]
)

render_files = files(
	'graphics/Renderer.cpp', # see [note 1]
	'simulation/Simulation.cpp', # see [note 1]
	'client/GameSave.cpp', # see [note 1]
	'PowderToyRenderer.cpp', # see [note 1]
)

font_files = files(
	'graphics/Renderer.cpp', # see [note 1]
	'gui/font/FontEditor.cpp', # see [note 1]
	'PowderToyFontEditor.cpp', # see [note 1]
)

subdir('client')
subdir('lua')
subdir('graphics')
subdir('gui')
subdir('simulation')

common_dep = declare_dependency(link_with: static_library(
	'common',
	sources: files(
		'bson/BSON.cpp',
		'json/jsoncpp.cpp',
		'common/String.cpp',
		'common/tpt-rand.cpp',
		'Format.cpp',
		'Misc.cpp',
		'Platform.cpp',
		'Probability.cpp',
	),
	dependencies: project_dep,
	include_directories: project_inc,
	cpp_args: project_cpp_arg,
))
