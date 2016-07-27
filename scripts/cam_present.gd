
extends Camera2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)

func _process(delta):
	var mouse = get_local_mouse_pos()+get_camera_screen_center()
	set_pos(get_pos().linear_interpolate(mouse,delta*5))
	
	