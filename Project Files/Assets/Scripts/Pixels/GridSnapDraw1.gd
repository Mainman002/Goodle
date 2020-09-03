extends TextureRect

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")

func _ready():
	Events._initialize_nodes_list(name, get_path())

func _process(_delta):
	if FuncManager.grid_showing == true:
		update()

func _draw():
	if FuncManager.grid_showing == true:
		for x in range(0,FuncManager.grid_size.x, FuncManager.cell_size):
			for y in range(0,FuncManager.grid_size.y,FuncManager.cell_size):
				draw_line(Vector2(x,y),Vector2(x,y+FuncManager.cell_size),Color(FuncManager.gridColor),1.0)
				draw_line(Vector2(x,y),Vector2(x+FuncManager.cell_size,y),Color(FuncManager.gridColor),1.0)
