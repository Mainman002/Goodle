extends CheckBox

export (Array, NodePath) var node_toggle

var bla = []

func _ready():
# warning-ignore:return_value_discarded
	connect("toggled", self, "_toggle")
	pressed = get_node(node_toggle[0]).visible

func _toggle(value):
	for i in node_toggle.size():
		get_node(node_toggle[i]).visible = value
