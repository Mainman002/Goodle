extends ColorRect

var hovering = false

#var ColorUndoList = []
#var currentUndoStep = 0
#var previousUndoStep = 0

const colorPickerNode = "../../../../../../UISC/UIVB/ColorPicker"

onready var  FuncManager = get_node("/root/MainMenu/FunctionController")
onready var cursorCenter = get_node("/root/MainMenu/CursorCenter")

func _ready():
	$Area2D.connect("area_entered", self, "_hovering")
	color = Color(0, 0, 0, 0)
#	Events._initialize_pixels_list(name, get_path(), color)
#	if FuncManager.canUndo == true:
	get_parent()._initialize_pixels_list(name, get_path(), color)
	get_parent()._initialize_ColorUndoList0_list(name, get_path(), color)
	get_parent()._initialize_ColorUndoList1_list(name, get_path(), color)
	get_parent()._initialize_ColorUndoList2_list(name, get_path(), color)
	get_parent()._initialize_ColorUndoList3_list(name, get_path(), color)
	get_parent()._initialize_ColorUndoList4_list(name, get_path(), color)
	get_parent()._initialize_ColorUndoList5_list(name, get_path(), color)

#func _update_Undo_Step():
#	if get_parent().currentUndoStep == 0:
#		get_parent()._initialize_ColorUndoList0_list(name, get_path(), color)
#	elif get_parent().currentUndoStep == 1:
#		get_parent()._initialize_ColorUndoList1_list(name, get_path(), color)
#	elif get_parent().currentUndoStep == 2:
#		get_parent()._initialize_ColorUndoList2_list(name, get_path(), color)
#	elif get_parent().currentUndoStep == 3:
#		get_parent()._initialize_ColorUndoList3_list(name, get_path(), color)
#	elif get_parent().currentUndoStep == 4:
#		get_parent()._initialize_ColorUndoList4_list(name, get_path(), color)
#	elif get_parent().currentUndoStep == 5:
#		get_parent()._initialize_ColorUndoList5_list(name, get_path(), color)

func _input(event):
	
#	if Input.is_key_pressed(KEY_CONTROL) and Input.is_key_pressed(KEY_Z):
#		_undo()
	
#	if Input.is_key_pressed(KEY_CONTROL) and Input.is_key_pressed(KEY_Y):
#		_redo()
	
	if FuncManager.panelOpen == false and hovering == true:
		if Input.is_mouse_button_pressed(1):
			if FuncManager.selectedTool == "Pencil":
				color = FuncManager.activeColor
#				_update_Undo_Step()
	
			elif FuncManager.selectedTool == "Picker":
				FuncManager.picker_Changed(color)
	
			elif FuncManager.selectedTool == "Eraser":
				color = Color(0,0,0,0)
#				_update_Undo_Step()


#		if Input.is_action_pressed("paint"):
#			if FuncManager.selectedTool == "Painter":
#				color = FuncManager.activeColor

		elif Input.is_mouse_button_pressed(2):
#			if FuncManager.selectedTool == "Eraser":
			color = Color(0,0,0,0)
#			_update_Undo_Step()

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
#					_update_Undo_Step()
				if color == FuncManager.eraseColor:
					color = Color(0,0,0,0)
#					_update_Undo_Step()
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
#					_update_Undo_Step()
		#			print("drawing")

			elif FuncManager.selectedTool == "Picker" and color != FuncManager.activeColor:
				if Input.is_mouse_button_pressed(1):
					FuncManager.picker_Changed(color)
		#			print("picking")

			elif FuncManager.selectedTool == "Eraser":
				if Input.is_mouse_button_pressed(1):
					color = Color(0,0,0,0)
#					_update_Undo_Step()
	#				print("erasing")

			if Input.is_action_pressed("erase"):
				color = Color(0,0,0,0)
#				_update_Undo_Step()
	#			print("erasing")

			if Input.is_action_pressed("colorPick") and color != FuncManager.activeColor:
				FuncManager.picker_Changed(color)
		#		print("picking")

#	if Input.is_action_just_released("paint"):
#		_update_Undo_Step()
#	elif Input.is_action_just_released("erase"):
#		_update_Undo_Step()



func _hovering(area):
	if area.is_in_group("Cursor"):
		if FuncManager.cursorExactSnapping == true:
			if cursorCenter.global_position != rect_global_position:
				cursorCenter.global_position = Vector2(rect_global_position.x+FuncManager._GridScales[FuncManager._GridCursorSnappOffset], rect_global_position.y+FuncManager._GridScales[FuncManager._GridCursorSnappOffset])



