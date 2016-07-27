extends AnimatedSprite
func _ready():
	get_node("AnimatedSprite/scale").seek(randi()%5)
	get_node("AnimatedSprite/rot").seek(randi()%5)
func set_type(type):
	get_node("AnimatedSprite").set_frame(type)