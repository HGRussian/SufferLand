
extends Node2D

func _ready():
	pass

func _on_bt_stopZombie_pressed():
	var npc_node = get_parent().get_node('NPC')
	for npc in npc_node.get_children():
		npc.activ=false

func _on_bt_runZombie_pressed():
	var npc_node = get_parent().get_node('NPC')
	for npc in npc_node.get_children():
		npc.activ=true