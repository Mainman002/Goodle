extends ColorRect

export (int) var colNum = 1
#export (NodePath) var currentColor
#export (NodePath) var colorPicker

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
# warning-ignore:return_value_discarded
	$TB.connect("pressed", self, "_colorSwap")

func _colorSwap():
	if FuncManager.panelOpen == false:
		FuncManager._color_Update(colNum, color)
		get_node(Events.nodes["VirtualGrid"].Path).visible = FuncManager.grid_showing


