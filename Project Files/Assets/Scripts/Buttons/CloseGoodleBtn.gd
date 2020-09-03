extends Button


func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "_pressed")

func _pressed():
	get_tree().quit()
