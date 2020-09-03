extends VBoxContainer

func _ready(): # get_viewport().get_rect().size
	rect_size = get_viewport_rect().size

func _process(_delta):
	if $"/root/Global".isExporting == false:
		if rect_size != get_viewport_rect().size:
			rect_size = get_viewport_rect().size
#			print(str("re-sized: ", rect_size))
