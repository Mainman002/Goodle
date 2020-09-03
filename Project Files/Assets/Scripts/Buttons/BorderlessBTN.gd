extends CheckBox

export (bool) var borderless = false

func _ready():
# warning-ignore:return_value_discarded
	connect("toggled", self, "_toggled")
	OS.window_borderless = borderless

func _toggled(value):
	OS.window_borderless = value
