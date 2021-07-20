extends KinematicBody2D
class_name PlayerController

const SPEED = 64
const RUN_SPEED = 96

onready var sprite_body = $body
onready var sprite_legs = $legs
onready var anim = $anim

var is_move = false
var is_runing = false
var move_vec = Vector2()

var crosshair


func _enter_tree() -> void:
	$"/root/_InGame".register_node("Player", self)


func _ready() -> void:
	crosshair = $"/root/_InGame".pick_node("Crosshair")


func _input(event) -> void:
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)


func _process(delta: float) -> void:
	var dir = get_move_dir()
	
	move_vec = dir.normalized()
	is_move = dir != Vector2()
	is_runing = Input.is_action_pressed("run")
	
	update_rotation()
	update_anim()


func get_move_dir() -> Vector2:
	var dir = Vector2()
	if Input.is_action_pressed("move_up"):
		dir.y -= 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	return dir


func update_rotation() -> void:
	sprite_body.look_at(get_global_mouse_position())
	sprite_body.rotate(deg2rad(90))
	
	if not is_move:
		sprite_legs.look_at(get_global_mouse_position())
	else:
		sprite_legs.look_at(global_position + move_vec)
	sprite_legs.rotate(deg2rad(90))


func update_anim() -> void:
	if is_move:
		if is_runing:
			play_anim("player_run")
		else:
			play_anim("player_walk")
	else:
		play_anim("player_idle")


func play_anim(anim_name: String) -> void:
	if anim.current_animation != anim_name:
		anim.play(anim_name)


func _physics_process(delta: float) -> void:
	move_and_slide(move_vec * (RUN_SPEED if is_runing else SPEED))
