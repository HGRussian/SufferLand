extends CanvasLayer


func _enter_tree() -> void:
	$"/root/_InGame".register_node("UI", self)
