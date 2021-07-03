extends Position2D

const SHOOT_DELAY = 0.12

var bullet = preload("res://assets/objects/weapons/bullet.tscn")

var current_delay = 0

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	current_delay += delta
	if Input.is_action_pressed("shoot") and current_delay >= SHOOT_DELAY:
		current_delay = 0
		var b = bullet.instance()
		b.global_position = global_position
		b.dir = Vector2(0, -1).rotated(global_rotation + deg2rad(rand_range(-5,5)))
		get_tree().root.add_child(b)
