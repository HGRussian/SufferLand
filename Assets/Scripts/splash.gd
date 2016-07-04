
extends Node2D
		
onready var game = get_parent()
onready var npc_node = game.get_node('NPC')
onready var gg = game.get_node("player")
onready var cm = game.get_node('worldGen/cm')

func init_settings():
	if not get_node('.').is_inside_tree():
		if game.get_parent().sound==false:
			get_node('sp_noise').stop()
		else:
			get_node('sp_noise').play()

func _ready():
	pass
	
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


func _on_Button_pressed():
	pass # replace with function body


func _on_bt_exmode_pressed():
	if cm.is_visible()==true:
		cm.set_hidden(true)
		gg.get_node('Light').set_hidden(true)
	else:
		cm.set_hidden(false)
		gg.get_node('Light').set_hidden(false)