extends Button

export (String) var PanelNode = "FilesPanel"

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_showPanel")

func _showPanel():
	get_node(Events.nodes[PanelNode].Path).visible = true
	FuncManager.panelOpen = true

