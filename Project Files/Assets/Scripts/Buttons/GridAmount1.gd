extends Button

var PixSize = 2

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "_pressed")

func _pressed():
	if PixSize == 0:
#		FuncManager.pixelGrid(0, 0, 0, 0)
		FuncManager._spawn(8, 8*8, 0)
		text = "8"
		PixSize = 2
	elif PixSize == 1:
#		FuncManager.pixelGrid(1, 1, 1, 1)
		FuncManager._spawn(16, 16*16, 1)
		text = "16"
		PixSize = 0
	elif PixSize == 2:
#		FuncManager.pixelGrid(2, 2, 2, 2)
		FuncManager._spawn(32, 32*32, 2)
		text = "32"
		PixSize = 1



