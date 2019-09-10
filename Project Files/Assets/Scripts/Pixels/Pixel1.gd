extends ColorRect

var hovering = false

const colorPickerNode = "../../../../../../UISC/UIVB/ColorPicker"

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")
onready var cursorCenter = get_node("/root/MainMenu/CursorCenter")

func _ready():
	$Area2D.connect("area_entered", self, "_hovering")
	color = Color(0, 0, 0, 0)
	Events._initialize_pixels_list(name, get_path(), color)

func _input(event):
	if FuncManager.panelOpen == false and hovering == true:
		if Input.is_mouse_button_pressed(1):
			if FuncManager.selectedTool == "Pencil":
				color = FuncManager.activeColor
	
			elif FuncManager.selectedTool == "Picker":
				FuncManager.picker_Changed(color)
	
			elif FuncManager.selectedTool == "Eraser":
				color = Color(0,0,0,0)


#		if Input.is_action_pressed("paint"):
#			if FuncManager.selectedTool == "Painter":
#				color = FuncManager.activeColor

		elif Input.is_mouse_button_pressed(2):
#			if FuncManager.selectedTool == "Eraser":
			color = Color(0,0,0,0)

		elif Input.is_mouse_button_pressed(3):
#			if FuncManager.selectedTool == "Picker":
			FuncManager.picker_Changed(color)




	
#			elif FuncManager.selectedTool == "Color Eraser":
#				if hovering == true:
#					FuncManager.eraseColor = color
#				if color == FuncManager.eraseColor:
#					color = Color(0,0,0,0)

func _physics_process(delta):
	if FuncManager.panelOpen == false:
		if FuncManager.selectedTool == "Color Eraser":
			if Input.is_mouse_button_pressed(1):
				if hovering == true:
					FuncManager.eraseColor = color
				if color == FuncManager.eraseColor:
					color = Color(0,0,0,0)
		#		print("erasing")
	
#		if hovering == true:
#			if FuncManager.selectedTool == "Painter" and Input.is_action_pressed("paint"):
#				color = FuncManager.activeColor
#
#			if FuncManager.selectedTool == "Picker" and Input.is_action_pressed("colorPick"):
#				FuncManager.picker_Changed(color)
#
#			if FuncManager.selectedTool == "Eraser" and Input.is_action_pressed("erase"):
#				color = Color(0,0,0,0)



		elif hovering == true:
			if FuncManager.selectedTool == "Pencil" and color != FuncManager.activeColor:
				if Input.is_action_pressed("paint"):
					color = FuncManager.activeColor
		#			print("drawing")

			elif FuncManager.selectedTool == "Picker" and color != FuncManager.activeColor:
				if Input.is_mouse_button_pressed(1):
					FuncManager.picker_Changed(color)
		#			print("picking")

			elif FuncManager.selectedTool == "Eraser":
				if Input.is_mouse_button_pressed(1):
					color = Color(0,0,0,0)
	#				print("erasing")

			if Input.is_action_pressed("erase"):
				color = Color(0,0,0,0)
	#			print("erasing")

			if Input.is_action_pressed("colorPick") and color != FuncManager.activeColor:
				FuncManager.picker_Changed(color)
		#		print("picking")

func _hovering(area):
	if area.is_in_group("Cursor"):
		if FuncManager.cursorExactSnapping == true:
			if cursorCenter.global_position != rect_global_position:
				cursorCenter.global_position = Vector2(rect_global_position.x+FuncManager._GridScales[FuncManager._GridCursorSnappOffset], rect_global_position.y+FuncManager._GridScales[FuncManager._GridCursorSnappOffset])



