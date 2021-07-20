extends KinematicBody2D

var player
var nav
var target_arr = []

var blood_part = preload("res://assets/particles/blood_shot.tscn")

var _dir = Vector2(0, -1)

var hp = 3

func _ready() -> void:
	randomize()
#	global_rotation_degrees = rand_range(-180, 180)
	_dir = _dir.rotated(global_rotation)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	player = $"/root/_InGame".pick_node("Player")
	nav = $"/root/_InGame".pick_node("Nav")
	if nav == null:
		printerr("Can't found Nav node")


func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	if not target_arr.empty():
		if global_position.distance_to(target_arr[0]) < 16:
			target_arr.remove(0)
	
	if target_arr.empty():
		var target_pos = player.global_position
		target_pos += Vector2(rand_range(-128, 128), rand_range(-128, 128))
		var p = (nav as Navigation2D).get_closest_point(target_pos)
		target_arr = (nav as Navigation2D).get_simple_path(global_position, p)
	
	var rot = global_position.angle_to_point(target_arr[0]) + deg2rad(- 90 )
#	_dir = Vector2(0, -1).rotated(rot)
	_dir = _dir.linear_interpolate(Vector2(0, -1).rotated(rot), 3 * delta)
	
	move_and_slide(_dir.normalized() * 96)
	$body.look_at(global_position + _dir)
	$body.rotation += deg2rad(90)
	update()


func damage(val: int, dir: Vector2) -> void:
	var b = blood_part.instance()
	b.global_position = global_position
	get_tree().current_scene.add_child(b)
	b.look_at(global_position + dir)
	
	hp -= val
	
	if hp <= 0:
		$anim.play("die")
		set_physics_process(false)
		$col.queue_free()

#func _draw() -> void:
#	if player != null:
#		draw_circle(player.global_position - global_position, 2, Color.yellow)
#
#	for p in target_arr:
#		draw_circle(p - global_position, 2, Color.red)
#
#	draw_line(Vector2(), _dir * 10, Color.aqua, 2)
