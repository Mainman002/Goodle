extends CheckBox

export (bool) var fullscreen = false

func _ready():
# warning-ignore:return_value_discarded
	connect("toggled", self, "_toggled")
	OS.window_fullscreen = fullscreen

func _toggled(value):
	OS.window_fullscreen = value
