
extends KinematicBody2D

var MOTION_SPEED = 100 # Pixels/second
var playing_anim = "idle"

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
	if motion == Vector2(0,0):
		get_node("Legs").set_rot(get_node("Body").get_rot())
		if playing_anim != "idle":
			get_node("leg_anim").play("idle")
			playing_anim = "idle"
	else:
		if playing_anim != "walk":
			get_node("leg_anim").play("walk")
			playing_anim = "walk"
		get_node("Legs").set_rot(get_node("Legs").get_global_pos().angle_to_point(get_global_pos()+motion))
	move(motion)
	
	var mousePos = get_node("cam").get_local_mouse_pos()
	get_node("Body").set_rot(get_node("Body").get_pos().angle_to_point(mousePos))
	if (Input.is_action_pressed("free_cam")):
		get_node("cam").set_pos(mousePos)
	else:
		get_node("cam").set_pos(mousePos/5)
	
	if (get_parent().get_node("map").get_cellv(get_parent().get_node("map").world_to_map( get_pos())) == 1):
		get_node("Legs").hide()
		MOTION_SPEED = 50
	else:
		get_node("Legs").show()
		MOTION_SPEED = 100

func _ready():
	set_fixed_process(true)

