extends TextureButton

export (bool) var isVisible
export (NodePath) var VirtualGrid

var visibleToggled

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_pressed")
	visibleToggled = isVisible

func _pressed():
	if FuncManager.panelOpen == false:
		FuncManager._grid_Update()
		get_node(VirtualGrid).visible = FuncManager.grid_showing
#		if visibleToggled == true:
#			visibleToggled = false
#		else:
#			visibleToggled = true
		
		
#		get_node(Grid).visible = FuncManager.grid_showing
