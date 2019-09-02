extends Button

export (NodePath) var mainCam
export (NodePath) var canvasCam
export (NodePath) var fileDialog
export (NodePath) var bgColor
export (NodePath) var xWidth
export (NodePath) var yHeight
export (NodePath) var CursorSprite
export (NodePath) var Grid
export (NodePath) var VirtualGrid

var filePath = "user://"
var fileName

var windowMaximized = false
var windowSizeX = 960
var windowSizeY = 540
var exportWindowSizeX = 64
var exportWindowSizeY = 64

const textureSizeLimitMin = 8
const textureSizeLimitMax = 8192

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")
onready var CursorCenter = get_node("/root/MainMenu/CursorCenter")

func _ready():
	connect("pressed", self, "_FileBroweser")
	get_node(fileDialog).connect("confirmed", self, "_CaptureScreen")
	windowSizeX = OS.window_size.x
	windowSizeY = OS.window_size.y
	windowMaximized = OS.window_maximized

func _FileBroweser():
	FuncManager.can_draw = false
	get_node(fileDialog).visible = true

func _screenTakeImage():
	get_node(bgColor).visible = false
	get_node("/root/MainMenu/FilesPanel").visible = false
	if FuncManager.grid_showing == true:
#		FuncManager._grid_Update()
		get_node(VirtualGrid).visible = false
	get_node(CursorSprite).visible = false
	CursorCenter.visible = false
	
#	windowSizeX = OS.window_size.x
#	windowSizeY = OS.window_size.y
	
	if str2var(get_node(xWidth).text) < textureSizeLimitMin:
		get_node(xWidth).text = str(textureSizeLimitMin)
	elif str2var(get_node(xWidth).text) > textureSizeLimitMax:
		get_node(xWidth).text = str(textureSizeLimitMax)
		
	if str2var(get_node(yHeight).text) < textureSizeLimitMin:
		get_node(yHeight).text = str(textureSizeLimitMin)
	elif str2var(get_node(yHeight).text) > textureSizeLimitMax:
		get_node(yHeight).text = str(textureSizeLimitMax)
	
	windowMaximized = OS.window_maximized
	OS.window_maximized = false
	
	OS.window_size.x = str2var(get_node(xWidth).text)
	OS.window_size.y = str2var(get_node(yHeight).text)
	
	get_node(canvasCam).current = true
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
#	get_viewport().render_target_v_flip = true
	get_viewport().transparent_bg = true

func _screenReset():
	get_node(mainCam).current = true
	OS.window_size.x = windowSizeX
	OS.window_size.y = windowSizeY
	get_node(bgColor).visible = true
	get_node("/root/MainMenu/FilesPanel").visible = true
	if FuncManager.grid_showing == true:
#		FuncManager._grid_Update()
		get_node(VirtualGrid).visible = true
	get_node(CursorSprite).visible = true
	CursorCenter.visible = true
	
	OS.window_maximized = windowMaximized
	
	FuncManager.can_draw = true
#	get_viewport().render_target_v_flip = false

func _CaptureScreen():
	_screenTakeImage()
	
	# Let two frames pass to make sure the screen was captured
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	# Retrieve the captured image
	var img = get_viewport().get_texture().get_data()
  
	# Flip it on the y-axis (because it's flipped)
	img.flip_y()

	# Create a texture for it
	var tex = ImageTexture.new()
	tex.create_from_image(img)

	# Set it to the capture node
#	$Capture.set_texture(tex)
	
	tex.get_data().save_png(str(get_node(fileDialog).current_path, ".png"))
#	print(str($FileDialog.current_path, ".png"))
	_screenReset()