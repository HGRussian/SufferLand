extends Camera2D


func _process(delta: float) -> void:
	position = lerp(position, (get_global_mouse_position() - get_parent().global_position) / 3, 8 * delta)
