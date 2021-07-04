extends Node2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	update()

func _draw() -> void:
	draw_circle(Vector2(), 2.3, Color.white)
