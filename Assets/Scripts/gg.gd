
extends KinematicBody2D

var MOTION_SPEED = 100 # Pixels/second
var playing_anim = "idle"
var right_hand = true
var weapon_type = 1
# 0 - NO WEAPON
# 1 - ARBAlET
var arrow = preload ("res://Assets/Scenes/weapons/arrow.scn")

var timer_stop = true

var shooting

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
		if (not timer_stop):
			get_node("Timer").stop()
			timer_stop = true
		get_node("Legs").set_rot(get_node("Body").get_rot())
		if playing_anim != "idle":
			get_node("leg_anim").play("idle")
			playing_anim = "idle"
	else:
		if (timer_stop):
			get_node("Timer").start()
			timer_stop = false
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

#water, legs, e.g.
#	if has_node("../Navigation2D/map"):
#		if (get_node("../Navigation2D/map").get_cellv(get_parent().get_node("Navigation2D/map").world_to_map( get_pos())) == 1):
#			get_node("Legs").hide()
#			MOTION_SPEED = 50
#		else:
#			get_node("Legs").show()
#			MOTION_SPEED = 100
	
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		if (weapon_type == 0):
			if (not get_node("body_anim").is_playing()):
				if (right_hand):
					get_node("body_anim").play("blow_right")
					right_hand = false
				else:
					get_node("body_anim").play("blow_left")
					right_hand = true
		if (weapon_type == 1):
			if (not get_node("Body/spawner/arb_anim").is_playing()):
				get_node("weaponSound").set_default_pitch_scale(1.1 + randf()/3.0)
				get_node("weaponSound").play("ArbaShot")
				get_node("Body/spawner/arb_anim").play("shot")
				var ar = arrow.instance()
				ar.set_pos(get_node("Body/spawner").get_global_pos())
				ar.set_rot(get_node("Body").get_rot())
				ar.set_linear_velocity((get_node("Body/spawner").get_global_pos()-get_node("Body/spawner/vector").get_global_pos()).normalized()*-300)
				get_node("..").add_child(ar)
	shooting = Input.is_mouse_button_pressed(BUTTON_LEFT)

func _ready():
	randomize()
	set_fixed_process(true)

#GAME_OVER
func GO():
	pass
	#get_node("../genTimerZombie").queue_free()
	#get_node("../ui/gameover").show()
	#get_node("../zombie").queue_free()
	#queue_free()