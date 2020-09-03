extends TextureButton

export (NodePath) var manager_path

func _toggled(_value):
	get_node(manager_path)._grid_Update()

