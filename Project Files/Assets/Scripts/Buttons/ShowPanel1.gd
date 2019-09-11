extends Button

export (String) var PanelNode = "FilesPanel"

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_showPanel")
	Events._initialize_nodes_list(name, get_path())

func _showPanel():
	if FuncManager.panelOpen == false:
		get_node(Events.nodes[PanelNode].Path).visible = true
		FuncManager.panelOpen = true

