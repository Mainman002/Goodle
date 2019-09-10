extends TextureButton

export (bool) var notVisible
#export (NodePath) var VirtualGrid
#export (Texture) var sprite_normal

var visibleToggled

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_pressed")
#	texture_normal = sprite_normal

	yield(get_tree(), "idle_frame")
	_start_Check()


func _start_Check():
	pressed = notVisible
	visibleToggled = notVisible
	FuncManager.grid_showing = notVisible
	FuncManager._grid_Update()
	get_node(Events.nodes["VirtualGrid"].Path).visible = FuncManager.grid_showing

func _pressed():
	if FuncManager.panelOpen == false:
		pressed = FuncManager.grid_showing
		FuncManager._grid_Update()
		get_node(Events.nodes["VirtualGrid"].Path).visible = FuncManager.grid_showing
	
