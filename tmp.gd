extends Node

var ratio = 1.25

func _ready():
	ratio = OS.get_screen_size().x / OS.get_screen_size().y
	print (ratio)
	_resize(ratio)
	set_process_input(true)

func _input(event):
	if (event.type == 1): #KEY
		if(event.is_action_pressed("M_KEY_ESCAPE")):
			get_tree().quit()

func _resize(r):
	ratio = r
	OS.set_window_fullscreen(false)
	OS.set_window_size(Vector2(round (120*ratio), 120))
	OS.set_window_fullscreen(true)
	
	print (round (120*ratio))
	
	print (str (get_tree().get_current_scene().get_path()) + "/Node2D/Sprite")
	if (has_node(NodePath(str (get_tree().get_current_scene().get_path()) + "/Node2D/Sprite"))):
		get_tree().get_current_scene().get_node("Node2D/Sprite").get_material().set_shader_param("Vec3",Vector3(0.005,ratio/200,0))