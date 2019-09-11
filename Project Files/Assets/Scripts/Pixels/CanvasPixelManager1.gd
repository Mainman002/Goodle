extends GridContainer

var ColorUndoList = []
var max_undo = 5
var currentUndoStep = 0

var pixels = {}
var _p_keyName = ""
var _p_data = null

var ColorUndoListTemp = {}
var ColorUndoList0 = {}
var ColorUndoList1 = {}
var ColorUndoList2 = {}
var ColorUndoList3 = {}
var ColorUndoList4 = {}
var ColorUndoList5 = {}

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	yield(get_tree(), "idle_frame")
	get_node(Events.nodes["Undo0BTN"].Path).connect("pressed", self, "history0_Pressed")
	get_node(Events.nodes["Undo1BTN"].Path).connect("pressed", self, "history1_Pressed")
	get_node(Events.nodes["Undo2BTN"].Path).connect("pressed", self, "history2_Pressed")
	get_node(Events.nodes["Undo3BTN"].Path).connect("pressed", self, "history3_Pressed")
	get_node(Events.nodes["Undo4BTN"].Path).connect("pressed", self, "history4_Pressed")
#	get_node(Events.nodes["Undo5BTN"].Path).connect("pressed", self, "history5_Pressed")

func _initialize_pixels_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	pixels[_p_keyName] = _p_data
	pixels.keys().sort()
	ColorUndoListTemp = pixels

func _initialize_ColorUndoList0_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	ColorUndoList0[_p_keyName] = _p_data
	ColorUndoList0.keys().sort()

func _initialize_ColorUndoList1_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	ColorUndoList1[_p_keyName] = _p_data
	ColorUndoList1.keys().sort()

func _initialize_ColorUndoList2_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	ColorUndoList2[_p_keyName] = _p_data
	ColorUndoList2.keys().sort()

func _initialize_ColorUndoList3_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	ColorUndoList3[_p_keyName] = _p_data
	ColorUndoList3.keys().sort()

func _initialize_ColorUndoList4_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	ColorUndoList4[_p_keyName] = _p_data
	ColorUndoList4.keys().sort()

func _initialize_ColorUndoList5_list(_name, _path, _color):
	yield(get_tree(), "idle_frame")
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	ColorUndoList5[_p_keyName] = _p_data
	ColorUndoList5.keys().sort()

func _undo():
	if currentUndoStep < max_undo-1:
		currentUndoStep += 1
		yield(get_tree(), "idle_frame")
		_set_Undo_State(currentUndoStep)
#		print(str("Undo: ", currentUndoStep))

func _redo():
	if currentUndoStep > 0:
		currentUndoStep -= 1
		yield(get_tree(), "idle_frame")
		_set_Undo_State(currentUndoStep)
#		print(str("Redo: ", currentUndoStep))

func _input(event):
	
	if Input.is_action_just_pressed("Undo"):
		_undo()
	
	if Input.is_action_just_pressed("Redo"):
		_redo()
	
	if FuncManager.canUndo == true:
		if Input.is_action_just_released("paint"):
			if FuncManager.can_draw == true and FuncManager.panelOpen == false:
				_refresh_list()
		elif Input.is_action_just_released("erase"):
			if FuncManager.can_draw == true and FuncManager.panelOpen == false:
				_refresh_list()

func _refresh_list():
	for i in get_children():
		if currentUndoStep == 0:
			_initialize_ColorUndoList0_list(i.name, i.get_path(), i.color)
			ColorUndoListTemp = ColorUndoList0
		elif currentUndoStep == 1:
			_initialize_ColorUndoList1_list(i.name, i.get_path(), i.color)
			ColorUndoListTemp = ColorUndoList1
		elif currentUndoStep == 2:
			_initialize_ColorUndoList2_list(i.name, i.get_path(), i.color)
			ColorUndoListTemp = ColorUndoList2
		elif currentUndoStep == 3:
			_initialize_ColorUndoList3_list(i.name, i.get_path(), i.color)
			ColorUndoListTemp = ColorUndoList3
		elif currentUndoStep == 4:
			_initialize_ColorUndoList4_list(i.name, i.get_path(), i.color)
			ColorUndoListTemp = ColorUndoList4
		elif currentUndoStep == 5:
			_initialize_ColorUndoList5_list(i.name, i.get_path(), i.color)
			ColorUndoListTemp = ColorUndoList5

func history0_Pressed():
	_set_Undo_State(0)

func history1_Pressed():
	_set_Undo_State(1)

func history2_Pressed():
	_set_Undo_State(2)

func history3_Pressed():
	_set_Undo_State(3)

func history4_Pressed():
	_set_Undo_State(4)


func _set_Undo_State(_state):
	currentUndoStep = _state
	if _state == 0:
		for i in get_children():
			ColorUndoListTemp = ColorUndoList0
			get_node(pixels[i.name].Path).color = ColorUndoListTemp[i.name].Color
	elif _state == 1:
		for i in get_children():
			ColorUndoListTemp = ColorUndoList1
			get_node(pixels[i.name].Path).color = ColorUndoListTemp[i.name].Color
	elif _state == 2:
		for i in get_children():
			ColorUndoListTemp = ColorUndoList2
			get_node(pixels[i.name].Path).color = ColorUndoListTemp[i.name].Color
	elif _state == 3:
		for i in get_children():
			ColorUndoListTemp = ColorUndoList3
			get_node(pixels[i.name].Path).color = ColorUndoListTemp[i.name].Color
	elif _state == 4:
		for i in get_children():
			ColorUndoListTemp = ColorUndoList4
			get_node(pixels[i.name].Path).color = ColorUndoListTemp[i.name].Color
	elif _state == 5:
		for i in get_children():
			ColorUndoListTemp = ColorUndoList5
			get_node(pixels[i.name].Path).color = ColorUndoListTemp[i.name].Color




