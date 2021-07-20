extends Navigation2D

func _enter_tree() -> void:
	$"/root/_InGame".register_node("Nav", self)
