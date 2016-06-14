
extends Camera2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_pos(get_viewport().get_mouse_pos()-Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)/2+get_camera_screen_center())