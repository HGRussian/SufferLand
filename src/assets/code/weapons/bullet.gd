extends KinematicBody2D

const SPEED = 4096
const MAX_DIST = 2048

var dir = Vector2()

var _last_pos = Vector2()
var _init_pos = Vector2()

func _ready() -> void:
	_init_pos = global_position
	_last_pos = _init_pos

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
	draw_line((_last_pos - global_position) * 0.75, Vector2(), Color.white, 1.5, true)
	draw_line((_last_pos - global_position), Vector2(), Color.white, 1.1, true)
	_last_pos = global_position
