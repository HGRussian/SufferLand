extends Position2D

const SHOOT_DELAY = 0.13
const MAX_AMMO = 30
const RELOAD_TIME = 2

onready var flash_node = $fire_lights
onready var anim = $anim
var ui

var bullet = preload("res://assets/objects/weapons/bullet.tscn")

var current_delay = 0
var current_ammo = 0
var is_reloading = false
var current_reload_time = 0

func _ready() -> void:
	randomize()
	current_ammo = MAX_AMMO
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	ui = $"/root/_InGame".pick_node("UI")
	update_ui()

func _process(delta: float) -> void:
	# check ammo
	if current_ammo <= 0 and not is_reloading:
		reload()
		return
	
	# reloading
	if is_reloading:
		current_reload_time += delta
		if current_reload_time >= RELOAD_TIME:
			is_reloading = false
			current_ammo = MAX_AMMO
			update_ui()
		else:
			return
	
	# shoot logic
	current_delay += delta
	if current_delay >= SHOOT_DELAY and Input.is_action_pressed("shoot"):
		current_delay = 0
		var b = bullet.instance()
		b.global_position = global_position
		b.dir = Vector2(0, -1).rotated(global_rotation + deg2rad(rand_range(-5,5)))
		get_tree().root.add_child(b)
		flash_node.frame = randi() % 4
		anim.stop()
		anim.play("shoot")
		current_ammo -= 1
		update_ui()
	elif not is_reloading and Input.is_action_just_pressed("reload") and current_ammo < MAX_AMMO:
		reload()


func reload() -> void:
	current_ammo = 0
	is_reloading = true
	current_reload_time = 0
	update_ui()


func update_ui() -> void:
	if ui == null:
		return
	if is_reloading:
		ui.reloading_primary(MAX_AMMO)
	else:
		ui.set_primary_ammo(current_ammo, MAX_AMMO)
	
