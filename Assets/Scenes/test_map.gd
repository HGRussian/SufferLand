extends Node2D

var pickup = preload("res://Assets/Scenes/pickup.scn")

func _ready():
	createItem(0,get_node("player").get_global_pos()+Vector2(0,-20),1)
	createItem(1,get_node("player").get_global_pos()+Vector2(-20,-20),32)
	randomize()

func createItem(ID, pos, count = 1):
	var p = pickup.instance()
	p.get_node("icon").set_texture(load("res://Assets/Art/Props/"+ItemsList.Item[ID]+".png"))
	p.count = count
	p.name = ItemsList.Item[ID]
	p.ID = ID
	p.set_global_pos(pos)
	p.set_name(p.name)
	p.get_node("icon").set_rot(deg2rad(randi()%360))
	get_node("props").add_child(p)
	
	
