extends Area2D

export (NodePath) var BrushSizeLabel
export (NodePath) var BrushSizeSlider
export (NodePath) var ColorPickerNode
export (NodePath) var CurrentColorNode
export (NodePath) var Grid

var brushSize = 4
var grid_Snap = false

const brushPickerSize = 3

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")
onready var  CursorCenter = get_node("/root/MainMenu/CursorCenter")

#var cell_size = 8
#var coord = Vector2(0,0)
#onready var grid_size = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)

func _ready():
#	print(grid_size)
	get_node("../CursorCenter").connect("area_entered", self, "CanvasEntered")
	get_node("../CursorCenter").connect("area_exited", self, "CanvasExited")
	connect("area_entered", self, "PixelEntered")
	connect("area_exited", self, "PixelExited")
#	get_node(BrushSizeSlider).connect("value_changed", self, "_toolChanged")
	get_node(ColorPickerNode).color = FuncManager.activeColor
	FuncManager.Cursor = get_path()
	FuncManager.CursorColorMask = get_path()

#func _input(event):
func _input(event):
	if FuncManager.panelOpen == false:
		if event is InputEventMouseMotion:
			if grid_Snap == true:
				var pos = Vector2(int(event.position.x/FuncManager.cell_size), int(event.position.y/FuncManager.cell_size))
				if pos != FuncManager.coord:
					FuncManager.coord = pos
					global_position.x = FuncManager.coord.x * 8.1
					global_position.y = FuncManager.coord.y * 10.1
					print(FuncManager.coord)
		
		if brushSize < 64 and Input.is_action_just_pressed("brushPlus"):
			brushSize += 1
			_set_size(brushSize, brushSize/4, brushSize/4)
		elif brushSize > 0 and Input.is_action_just_pressed("brushMinus"):
			brushSize -= 1
			_set_size(brushSize, brushSize/4, brushSize/4)
	
		if Input.is_action_just_pressed("colorPick") or FuncManager.selectedTool == "Color Eraser":
			_set_size(2, .2, brushPickerSize)
		else:
			_set_size(brushSize, brushSize/4, brushSize/4)
		
			if FuncManager.selectedTool == "Picker":
				_set_size(2, .2, brushPickerSize)
			elif FuncManager.selectedTool == "Painter" or FuncManager.selectedTool == "Eraser":
				_set_size(brushSize, brushSize/4, brushSize/4)

func _physics_process(delta):
	if grid_Snap == false:
		if FuncManager.panelOpen == false:
			if global_position != get_global_mouse_position():
					global_position = get_global_mouse_position()
					if FuncManager.cursorExactSnapping == false:
						CursorCenter.global_position = global_position

func _toolChanged(value):
	if FuncManager.panelOpen == false:
		get_node(BrushSizeLabel).text = str(value)
#		brushSize = get_node(BrushSizeSlider).value
		brushSize = value
		$CShape2D.shape.radius = brushSize
		FuncManager.brushSize = brushSize

func _set_size(_size, _dec, _pickSize):
	if FuncManager.panelOpen == false:
		$CShape2D.shape.radius = _size
		$Sprite.scale = Vector2(_dec,_dec)
		$ColorMask.scale = Vector2(_pickSize,_pickSize)
#		get_node(BrushSizeSlider).value = _size
		FuncManager._brush_size_Update(_size, _dec, _pickSize)

func colorMaskUpdate(_color):
	$ColorMask.modulate = _color

func CanvasEntered(area):
	if FuncManager.panelOpen == false:
		if area.is_in_group("CanvasArea"):
			FuncManager.can_draw = true
	#		print("entered Canvas")

func CanvasExited(area):
	if area.is_in_group("CanvasArea"):
		FuncManager.can_draw = false
#		print("left Canvas")

func PixelEntered(area):
	if FuncManager.can_draw == true:
		if area.is_in_group("Pixel"):
			area.get_parent().hovering = true
#			if FuncManager.cursorExactSnapping == true:
#				get_node("root/MainMenu/CursorCenter").global_position = Vector2(area.rect_global_position.x+FuncManager._GridScales[FuncManager._GridCursorSnappOffset], area.rect_global_position.y+FuncManager._GridScales[FuncManager._GridCursorSnappOffset])

func PixelExited(area):
	if area.is_in_group("Pixel"):
		area.get_parent().hovering = false

#func _draw():
#	for x in range(0,CursorCenter.global_position.x, 4):
#		for y in range(0,CursorCenter.global_position.y,4):
#			draw_line(Vector2(x,y),Vector2(x,y+4),Color(1,1,1,1),1.0)
#			draw_line(Vector2(x,y),Vector2(x+4,y),Color(1,1,1,1),1.0)



