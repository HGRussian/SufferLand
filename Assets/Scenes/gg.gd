
extends KinematicBody2D

const MOTION_SPEED = 100 # Pixels/second


func _fixed_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("move_down")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	move(motion)
	
	var mousePos = get_node("Camera2D").get_local_mouse_pos()
	get_node("Sprite").set_rot(get_node("Sprite").get_pos().angle_to_point(mousePos))
	if (Input.is_action_pressed("free_cam")):
		get_node("Camera2D").set_pos(mousePos)
	else:
		get_node("Camera2D").set_pos(mousePos/5)

func _ready():
	set_fixed_process(true)

