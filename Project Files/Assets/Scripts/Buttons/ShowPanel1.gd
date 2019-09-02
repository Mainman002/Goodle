extends Button

export (NodePath) var PanelNode

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_showPanel")

func _showPanel():
	get_node(PanelNode).visible = true
	FuncManager.panelOpen = true

