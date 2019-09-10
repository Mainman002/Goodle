extends TextureButton

#export (String) var toolMode
#export (NodePath) var toolLabel
export (int) var SelectedTool = 0
#export (NodePath) var Cursor
#export (int) var brushSize = 4

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_pressed")

func _pressed():
	if FuncManager.panelOpen == false:
		FuncManager._tool_Update(SelectedTool)
