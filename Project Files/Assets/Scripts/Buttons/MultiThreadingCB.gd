extends CheckBox

func _ready():
# warning-ignore:return_value_discarded
	connect("toggled", self, "_toggled")
	
func _toggled(value):
	if value:
		pass
