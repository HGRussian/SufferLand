extends Node2D

var player


func _enter_tree() -> void:
	$"/root/_InGame".register_node("Crosshair", self)


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	player = $"/root/_InGame".pick_node("Player")


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	var mpos = get_viewport().get_canvas_transform()\
			.affine_inverse().xform(get_viewport().get_mouse_position())
	var angle = player.global_position.angle_to_point(mpos)
	rotation = angle + deg2rad(-90)
	
	update()


func set_primary_ammo(current_ammo, max_ammo, reloading = false) -> void:
	var t = (get_node("primary_ammo") as TextureProgress)
	t.max_value = max_ammo
	t.value = current_ammo
	t.tint_progress = Color(1,1,1, 0.25 if reloading else 1)


func _draw() -> void:
	draw_circle(Vector2(), 2.3, Color.white)
