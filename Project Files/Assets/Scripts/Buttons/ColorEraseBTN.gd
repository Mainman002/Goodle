extends Button

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	connect("pressed", self, "_pressed")

func _pressed():
	pass
