extends VSlider

func _ready():
	Events._initialize_nodes_list(name, get_path())
