extends KinematicBody2D

var Damage = 25
onready var txtLabel = get_node("/root/MainMenu/Label")

func _ready():
	Events._initialize_nodes_list(name, get_path())
	
	
	yield(get_tree(), "idle_frame")
	_Attacked(Damage)

func _Attacked(damage:int = Damage):
#	Events.emit_signal("_Attacked", damage)
	txtLabel.text = str("Damage: ", damage)
	print(str("Damage: ", damage))
	
	if Events.nodes.has("Label2"):
		get_node(Events.nodes["Label2"].Path).text = str("test Text: ", name)




