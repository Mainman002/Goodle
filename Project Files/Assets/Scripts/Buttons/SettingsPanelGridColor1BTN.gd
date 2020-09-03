extends ColorRect

export (NodePath) var _ColorPicker

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
# warning-ignore:return_value_discarded
	$TB.connect("pressed", self, "_colorOpen")
# warning-ignore:return_value_discarded
	get_node(_ColorPicker).connect("color_changed", self, "_colorUpdate")
	get_node(_ColorPicker).color = FuncManager.gridColor
	modulate = FuncManager.gridColor

func _colorOpen():
	if get_node(_ColorPicker).visible == true:
		get_node(_ColorPicker).visible = false
	else:
		get_node(_ColorPicker).visible = true

func _colorUpdate(color):
	FuncManager.grid_col_changed(color)
	modulate = color
