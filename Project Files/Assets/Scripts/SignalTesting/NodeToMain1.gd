extends Node

#onready var MainRoot = get_node("/root/MainMenu")

func _ready():
	Events._initialize_nodes_list(name, get_path())


