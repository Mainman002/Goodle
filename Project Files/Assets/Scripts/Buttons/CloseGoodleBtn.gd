extends Button


func _ready():
	connect("pressed", self, "_pressed")

func _pressed():
	get_tree().quit()
