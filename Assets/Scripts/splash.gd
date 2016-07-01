
extends Node2D

func _ready():
	pass

onready var game = get_parent()
onready var npc_node = game.get_node('NPC')
onready var gg = game.get_node("player")

func _on_bt_stopZombie_pressed():
	for npc in npc_node.get_children():
		npc.activ=false

func _on_bt_runZombie_pressed():
	for npc in npc_node.get_children():
		npc.activ=true

func _on_bt_nextLvl_pressed():
	game.nextLevel()


func _on_bt_debugMode_pressed():
	if gg.debug == true:
		gg.debug = false
	else:
		gg.debug = true
