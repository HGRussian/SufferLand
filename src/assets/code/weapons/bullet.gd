extends KinematicBody2D

const SPEED = 2048
const MAX_DIST = 2048

var dir = Vector2()

var _last_pos = Vector2()
var _pre_last_pos = Vector2()
var _init_pos = Vector2()

func _ready() -> void:
	_init_pos = global_position
	_last_pos = _init_pos
	_pre_last_pos = _last_pos

func _physics_process(delta: float) -> void:
	if (_init_pos.distance_to(global_position) > MAX_DIST):
		queue_free()
		return
	
	var col = move_and_collide(dir.normalized()*SPEED*delta)
	
	if col:
		update()
		set_physics_process(false)
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		queue_free()
		return
	
	update()

func _draw() -> void:
	draw_line(_last_pos - global_position, Vector2(), Color.white, 1.5)
	_last_pos = _pre_last_pos
	_pre_last_pos = global_position
