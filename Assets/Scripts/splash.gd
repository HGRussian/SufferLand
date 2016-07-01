
extends Node2D

func _ready():
	pass

onready var game = get_parent()
onready var npc_node = game.get_node('NPC')

func _on_bt_stopZombie_pressed():
	for npc in npc_node.get_children():
		npc.activ=false

func _on_bt_runZombie_pressed():
	for npc in npc_node.get_children():
		npc.activ=true

func _on_bt_nextLvl_pressed():
	game.nextLevel()


func _on_bt_debugMode_pressed():
	if get_node("../player").debug == true:
		get_node("../player").debug = false
	else:
		get_node("../player").debug = true
