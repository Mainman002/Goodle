extends GridContainer

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	for i in get_children():
		Events._initialize_nodes_list(i.name, i.get_path())
		i.connect("color_changed", self, "_changed")
		i.connect("pressed", self, "_pressed")
		i.connect("popup_closed", self, "_closed")

func _changed(color):
	FuncManager.picker_Changed(color)

func _pressed():
	FuncManager.panelOpen = true

func _closed():
	FuncManager.panelOpen = false

