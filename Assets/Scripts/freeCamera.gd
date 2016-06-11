extends Camera2D

var mousepos

func _ready():
	set_process(true)

func _process(delta):
	mousepos = get_viewport().get_mouse_pos()+get_camera_screen_center()-Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)/2
	set_pos(get_pos().linear_interpolate(mousepos/get_parent().get_scale().x,delta*5))

