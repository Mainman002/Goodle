extends Node2D

var players = {}
var keyName = ""
var data = null
var player_count = 0

func _ready():
	for i in get_children():
		_initialize_list(i.name, i.get_path())

func _initialize_list(_p_name, _p_path):
	keyName = _p_name
	data = {"Path" : _p_path}
	players[keyName] = data
	players.keys().sort()
	print(str("Nodes List: ", players))
	
#	_get_node("node1")
#	_get_node(_p_name)

func _get_node(_name):
	
	if players.has(_name):
#		for _name in players:
		print(_name, players[_name])
		get_node(players[_name].Path).text = str("testing: ", _name)
	



