extends Node

export (PackedScene) var pixel_node
export (int) var res = 8
export (NodePath) var grid_container

#export (NodePath) var Cursor
#export (NodePath) var toolLabel
#export (NodePath) var colorPicker
#export (NodePath) var currentColor
export (NodePath) var selectedColor1
export (NodePath) var selectedColor2
export (NodePath) var GridColorSetting
#export (NodePath) var FPSLabel
export (NodePath) var FPSCB
export (NodePath) var GridCont
#export (NodePath) var VirtualGrid
export (NodePath) var CursorCenterSnappingBTN

#var _node_Dict = [{"toolLabel":{"path":"null"}}, {"toolLabel2":{"path":"blank"}}]
#var _node_List = [get_path(), get_path()]

#var glob_toolLabel
#var glob_colorPicker

var printFPS = false

var Cursor
var CursorColorMask

var panelOpen = false
var can_draw = false
var selectedColor = 1
var activeColor = Color(0,0,0,1)
var col1 = Color(0,0,0,1)
var col2 = Color(1,1,1,1)
var eraseColor = Color(0,0,0,0)
var cursorExactSnapping = false
var selectedTool = "Pencil"
var activeTool = ["Pencil", "Picker", "Eraser", "Color Eraser"]

var brushSize = 4
var brushDecSize = .4
var pickSize = 2
var grid_showing = false
var gridColor = Color(0,.7,1,1)

### 8x8 | 16x16 | 32x32 px grid ###
var _GridCursorSnappOffset = 0
var _GridScales = [16, 8, 4]
var _GridColumns = [8, 16, 32]
var _GridTotals = [64, 256, 1024]
var _CellSizes = [32, 16, 8]

onready var GridScale = _GridScales[0]
onready var GridColumns = _GridColumns[0]
onready var GridTotal = _GridTotals[0]
onready var cell_size = _CellSizes[0]

onready var amount = res*res

var coord = Vector2(0,0)
onready var grid_size = Vector2(256, 256)

const pixelObj = preload("res://Assets/Instances/Pixels/P1.tscn")

func picker_Pressed():
	panelOpen = true

func picker_Closed():
	panelOpen = false

func _ready():
	yield(get_tree(), "idle_frame")
# warning-ignore:return_value_discarded
	get_node(Events.nodes["CurrentColor"].Path).connect("pressed", self, "picker_Pressed")
# warning-ignore:return_value_discarded
	get_node(Events.nodes["CurrentColor"].Path).connect("popup_closed", self, "picker_Closed")
# warning-ignore:return_value_discarded
	get_node(Events.nodes["CurrentColor"].Path).connect("color_changed", self, "picker_Changed")
# warning-ignore:return_value_discarded
	get_node(GridColorSetting).connect("color_changed", self, "grid_col_changed")
# warning-ignore:return_value_discarded
	get_node(FPSCB).connect("toggled", self, "_FPSToggle")
#	get_node(currentColor).color = activeColor
	get_node(GridColorSetting).color = gridColor
	get_node(GridCont).rect_scale = Vector2(GridScale, GridScale)
	get_node(GridCont).columns = GridColumns
# warning-ignore:return_value_discarded
	get_node(CursorCenterSnappingBTN).connect("toggled", self, "centerSnapToggle")
	
#	for i in GridTotal:
#		var Pobj = pixelObj.instance()
#		Pobj.name = str("P", i)
#		get_node(GridCont).add_child(Pobj)

#	print(str("new: ", res*res))
	_spawn(res, res*res, 0)
	
	_grid_Update()
	
#	print(str("toolLabel: ", glob_toolLabel))

#func _update_Var(_varName, _nodePath):
#	if _varName != null:
#		pass
#	if _nodePath != null:
#		pass

func _input(_event):
	if Input.is_action_just_pressed("PaintTool"):
		_tool_Update(0)
	if Input.is_action_just_pressed("EraseTool"):
		_tool_Update(2)
	if Input.is_action_just_pressed("ColorPickerTool"):
		_tool_Update(1)
	if Input.is_action_just_pressed("ColorEraseTool"):
		_tool_Update(3)
	
#	if Input.is_action_just_pressed("grid_toggle"):
#		_grid_Update()

func _process(_delta):
	if printFPS == true:
		get_node(Events.nodes["FPSLabel"].Path).text = (str("FPS: ", Engine.get_frames_per_second()))
	
	if panelOpen == false:
		if Input.is_action_just_pressed("color_swap"):
			if activeColor != col2 and selectedColor == 1:
				activeColor = col2
				get_node(Events.nodes["CurrentColor"].Path).color = col2
#				get_node(currentColor).color = col2
				get_node(CursorColorMask).colorMaskUpdate(col2)
				selectedColor = 2
			elif activeColor != col1 and selectedColor == 2:
				activeColor = col1
				get_node(Events.nodes["CurrentColor"].Path).color = col1
#				get_node(currentColor).color = col1
				get_node(CursorColorMask).colorMaskUpdate(col1)
				selectedColor = 1
			
		if Input.is_action_just_pressed("grid_toggle"):
			_grid_Update()
	

func _color_Update(_selected, _color):
	get_node(CursorColorMask).colorMaskUpdate(_color)
	if panelOpen == false:
		if _selected != null:
			selectedColor = _selected
		if _color != null:
			picker_Changed(_color)

func _tool_Update(_tool):
	if panelOpen == false:
		if selectedTool != activeTool[_tool]:
			selectedTool = activeTool[_tool]
			get_node(Events.nodes["ToolLabel"].Path).text = selectedTool
			
	#		_brush_size_Update(brushSize, brushDecSize, pickSize)
			get_node(Cursor)._set_size(brushSize, brushDecSize, pickSize)
			
	#		print(selectedTool)

func _brush_size_Update(_size, _dec, _pickSize):
	if panelOpen == false:
		if _size != null:
			brushSize = _size
		if _dec != null:
			brushDecSize = _dec
		if _pickSize != null:
			pickSize = _pickSize
	#	get_node(Cursor)._set_size(_size, _dec, _pickSize)

func picker_Changed(_color):
	get_node(CursorColorMask).colorMaskUpdate(_color)
	if panelOpen == false:
		activeColor = _color
		if selectedColor == 1:
			col1 = _color
			get_node(selectedColor1).color = _color
		elif selectedColor == 2:
			col2 = _color
			get_node(selectedColor2).color = _color
		
		get_node(Events.nodes["CurrentColor"].Path).color = _color
#		get_node(currentColor).color = _color

#func gridColorChange(_color):
#	get_node(Grid).self_modulate = _color

func _grid_Update():
	if grid_showing == false:
		grid_showing = true
	else:
		grid_showing = false
	get_node(Events.nodes["VirtualGrid"].Path).visible = grid_showing

func grid_col_changed(color):
	gridColor = color

#func pixelGrid(_grid_scale, _scale, _column, _amount):
#
#	GridScale = _GridScales[_scale]
#	GridColumns = _GridColumns[_column]
#	GridTotal = _GridTotals[_amount]
#	cell_size = _CellSizes[_grid_scale]
#
#	cell_size = _CellSizes[_grid_scale]
#
#	get_node(GridCont).rect_scale = Vector2(_GridScales[_scale], _GridScales[_scale])
#	get_node(GridCont).columns = _GridColumns[_column]
#
##	for i in get_node(GridCont).get_children():
##		i.queue_free()
##
##	for i in GridTotal:
##		var Pobj = pixelObj.instance()
##		Pobj.name = str("P", i)
##		get_node(GridCont).add_child(Pobj)
#
#	_spawn(_column, _amount)

func _FPSToggle(button_pressed):
	printFPS = button_pressed
	get_node(Events.nodes["FPSLabel"].Path).visible = button_pressed
	get_node(Events.nodes["FPSLabelHSep"].Path).visible = button_pressed

func centerSnapToggle(button_pressed):
	cursorExactSnapping = button_pressed
	get_node(Events.nodes["CursorCenter"].Path).visible = button_pressed





func _spawn(_col, _am, _scale):

	cell_size = _CellSizes[_scale]

	get_node(GridCont).rect_scale = Vector2(_GridScales[_scale], _GridScales[_scale])
	get_node(GridCont).columns = _col
	
	if get_node(GridCont).get_child_count() > _GridScales[_scale]:
		_free()
	
	for i in range(_am):
		var pixel = pixel_node.instance()
		get_node(GridCont).add_child(pixel)
		pixel.name = str("Pix_", i)

func _free():
#	print(get_node(GridCont).get_child_count())
	for i in range(get_node(GridCont).get_child_count()):
		get_node(GridCont).get_child(i).queue_free()








#func _cursorPosUpdate(_grid_size):
#	grid_size = _grid_size
#	_draw()

#func _draw():
#	for x in range(0,grid_size.x, cell_size):
#		for y in range(0,grid_size.y,cell_size):
#			get_node("/root/MainMenu").draw_line(Vector2(x,y),Vector2(x,y+cell_size),Color(0,1,0),1.0)
#			get_node("/root/MainMenu").draw_line(Vector2(x,y),Vector2(x+cell_size,y),Color(0,1,0),1.0)

