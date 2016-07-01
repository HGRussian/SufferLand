
extends KinematicBody2D
export var activ = false
var MOTION_SPEED = 100 # Pixels/second
var playing_anim = "idle"
var right_hand = true
var weapon_type = 1
# 0 - NO WEAPON
# 1 - ARBAlET
var arrow = preload ("res://Assets/Scenes/weapons/arrow.scn")

var debug = false
onready var debCam = get_node("cam")
var normalZoom = 0.5

var shooting

func anim_walk(motion, body, legs, anim):
	if motion == Vector2(0,0):
		legs.set_rot(body.get_rot())
		if playing_anim != "idle":
			anim.play("idle")
			playing_anim = "idle"
	else:
		if playing_anim != "walk":
			anim.play("walk")
			playing_anim = "walk"
		legs.set_rot(legs.get_global_pos().angle_to_point(get_global_pos()+motion))

func shot(world, weapon, body, spawner, vector, body_anim, weapon_anim):
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		if (weapon_type == 0):
			if (not body_anim.is_playing()):
				if (right_hand):
					body_anim.play("blow_right")
					right_hand = false
				else:
					body_anim.play("blow_left")
					right_hand = true
		if (weapon_type == 1):
			if (not weapon_anim.is_playing()):
				var ar = weapon.instance()
				var weapon_sound = ar.get_node('weaponSound')
				weapon_sound.set_default_pitch_scale(1.1 + randf()/3.0)
				weapon_sound.play("Shot")
				weapon_anim.play("shot")
				ar.set_pos(spawner.get_global_pos())
				ar.set_rot(body.get_rot())
				ar.set_linear_velocity((spawner.get_global_pos()-vector.get_global_pos()).normalized()*-300)
				world.add_child(ar)
	shooting = Input.is_mouse_button_pressed(BUTTON_LEFT)

func controller_gg(motion):
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("move_down")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
	return motion

func controller_freeCam(camera, center_obj):
	var mousePos = camera.get_local_mouse_pos()
	center_obj.set_rot(center_obj.get_pos().angle_to_point(mousePos))
	if (Input.is_action_pressed("free_cam")):
		camera.set_pos(mousePos)
	else:
		camera.set_pos(mousePos/5)
		
##############################################################

#############################################################
func _fixed_process(delta):
	if debug == true:
		if Input.is_action_pressed("zoom+") and debCam.get_zoom().x > 0.1:
			debCam.set_zoom(Vector2(debCam.get_zoom().x-0.001,debCam.get_zoom().y-0.001))
		if Input.is_action_pressed("zoom-") and debCam.get_zoom().x < 15:
			debCam.set_zoom(Vector2(debCam.get_zoom().x+0.001,debCam.get_zoom().y+0.001))
		if Input.is_action_pressed("zoomReset"):
			debCam.set_zoom(Vector2(lerp(debCam.get_zoom().x,normalZoom,0.1),lerp(debCam.get_zoom().y,normalZoom,0.1)))
	if debug == false:
		if debCam.get_zoom().x != normalZoom:
			debCam.set_zoom(Vector2(lerp(debCam.get_zoom().x,normalZoom,0.1),lerp(debCam.get_zoom().y,normalZoom,0.1)))
	if activ == true:
		var motion = Vector2()
		motion = controller_gg(motion)
		motion = motion.normalized()*MOTION_SPEED*delta
		anim_walk(motion, get_node("Body"), get_node("Legs"), get_node("leg_anim"))
		move(motion)
		controller_freeCam(get_node("cam"), get_node("Body"))
		shot(get_node(".."), arrow, get_node("Body"),get_node("Body/spawner"), get_node("Body/spawner/vector"), get_node("body_anim"), get_node("Body/spawner/arb_anim"))

func _ready():
	randomize()
	set_fixed_process(true)

#GAME_OVER
func GameOver():
	if debug != true:
		pass