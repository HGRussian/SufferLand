
extends Node2D
func clear_blood():
	for child in get_tree().get_current_scene().get_children():
		if str(child.get_name()).begins_with("blood"):
			get_tree().get_current_scene().remove_child(child)	
			
func blood(body):
	if (str(body.get_name()).begins_with("npc_zombie")):
		var b = load("res://Assets/Scenes/npc/zombie/zombie_blood.tscn").instance()
		b.set_pos((get_pos()-body.get_pos()).normalized()*5)
		b.set_rot(get_rot()+deg2rad(90))
		b.set_emitting(true)
		body.get_node("Body").add_child(b)
		var b = load("res://Assets/Scenes/npc/zombie/zombie_step_blood.tscn").instance()
		b.set_pos((get_pos()-body.get_pos()).normalized()*5)
		body.get_node("Body").add_child(b)
		if body.get_ded():
			var b = load("res://Assets/Scenes/npc/zombie/zombie_dead_blood.tscn").instance()
			b.set_pos(body.get_global_pos())
			b.set_emitting(true)
			b.set_emission_half_extents(Vector2(randi()%8+4,randi()%8+4))
			b.set_name('blood_dead_' + str(body.get_name()))
			get_tree().get_current_scene().add_child(b)

		
func _ready():
	pass


