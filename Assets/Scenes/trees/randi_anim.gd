
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("rot").set_speed(randf())
	get_node("scale").set_speed(randf())
	get_node("rot").seek(randf())
	get_node("scale").seek(randf())