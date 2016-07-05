
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("rot").set_speed(randf())
	get_node("scale").set_speed(randf())
	get_node("rot").seek(randf())
	get_node("scale").seek(randf())
	
	var nav = NavigationPolygonInstance.new()
	nav.set_navigation_polygon(load("res://Assets/Tiles/treenav.res"))
	nav.set_name("nav")
	nav.set_global_pos(get_global_pos())
	get_node("../..").add_child(nav)