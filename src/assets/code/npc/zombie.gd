extends KinematicBody2D

var player
var nav
var target_arr = []

var _dir = Vector2(0, -1)

func _ready() -> void:
	randomize()
#	global_rotation_degrees = rand_range(-180, 180)
	_dir = _dir.rotated(global_rotation)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	player = get_tree().current_scene.player_node
	nav = get_tree().current_scene.nav_node

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	if not target_arr.empty():
		if global_position.distance_to(target_arr[0]) < 16:
			target_arr.remove(0)
	
	if target_arr.empty():
		var target_pos = player.global_position
		target_pos += Vector2(rand_range(-32, 32), rand_range(-32, 32))
		var p = (nav as Navigation2D).get_closest_point(target_pos)
		target_arr = (nav as Navigation2D).get_simple_path(global_position, p)
	
	var rot = global_position.angle_to_point(target_arr[0]) + deg2rad(- 90 )
#	_dir = Vector2(0, -1).rotated(rot)
	_dir = _dir.linear_interpolate(Vector2(0, -1).rotated(rot), 2 * delta)
	
	move_and_slide(_dir.normalized() * 96)
	$body.look_at(global_position + _dir)
	$body.rotation += deg2rad(90)
	update()

#func _draw() -> void:
#	if player != null:
#		draw_circle(player.global_position - global_position, 2, Color.yellow)
#
#	for p in target_arr:
#		draw_circle(p - global_position, 2, Color.red)
#
#	draw_line(Vector2(), _dir * 10, Color.aqua, 2)
