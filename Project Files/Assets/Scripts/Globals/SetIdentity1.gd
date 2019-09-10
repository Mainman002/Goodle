extends Node

#export (String) var VarName

#onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	Events._initialize_nodes_list(name, get_path())
	
#	print(str("toolLabel: ", FuncManager._node_Dict))
#	_set_ID(get_path())

#func _set_ID(_path:NodePath):
#	FuncManager.glob_toolLabel = _path
#	print(str("toolLabel: ", FuncManager.glob_toolLabel))

