
extends Node2D
func init_settings():
	get_node('sp_noise').set_volume(get_parent().get_parent().sound_level)

func _ready():
	init_settings()
		
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
