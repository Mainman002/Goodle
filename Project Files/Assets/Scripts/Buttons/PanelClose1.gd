extends Button

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "_closePanel")

func _closePanel():
	get_node("../../").visible = false
#	FuncManager.can_draw = true
	FuncManager.panelOpen = false
