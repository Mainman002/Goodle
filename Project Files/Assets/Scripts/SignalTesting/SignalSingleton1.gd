extends Node

var nodes = {}
var _n_keyName = ""
var _n_data = null

var pixels = {}
var _p_keyName = ""
var _p_data = null

func _initialize_nodes_list(_name, _path):
	_n_keyName = _name
	_n_data = {"Path" : _path}
	nodes[_n_keyName] = _n_data
	nodes.keys().sort()
#	print(str("Node List: ", nodes))

func _initialize_pixels_list(_name, _path, _color):
	_p_keyName = _name
	_p_data = {"Path" : _path, "Color" : _color}
	pixels[_p_keyName] = _p_data
	pixels.keys().sort()
#	print(str("Pixels List: ", pixels))










#func _get_node(_name):
	
#	if nodes.has(_name):
#		for _name in players:
#		print(_name, nodes[_name])
#		get_node(nodes[_name].Path).text = str("testing: ", _name)






