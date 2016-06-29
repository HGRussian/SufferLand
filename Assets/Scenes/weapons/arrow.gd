extends RigidBody2D

func _on_Timer_timeout():
	queue_free()

func _on_checker_body_enter( body ):
	if (str(body.get_name()).begins_with("zombie")):
		get_node("checker").queue_free()
		if (body.has_method ("add_damage")):
			body.add_damage(1)
		var at = get_node("arrow").get_texture()
		var a = Sprite.new()
		a.set_texture(at)
		a.set_pos((get_pos()-body.get_pos()).normalized()*5)
		a.set_rot(get_rot())
		body.get_node("Body").add_child(a)
		if not body.get_ded():
			var b = load("res://Assets/Scenes/zombie_blood.tscn").instance()
			b.set_pos((get_pos()-body.get_pos()).normalized()*5)
			b.set_rot(get_rot())
			b.set_emitting(true)
			body.get_node("Body").add_child(b)
		queue_free()
	elif body.get_name() != "player":
		queue_free()
