
extends Control
onready var tf_logo = get_node('cl/tf_logo')
onready var cc_for_bt = get_node('cl/cc_for_bt')
onready var cc_for_tc = get_node('cl/cc_for_tc')

func _ready():
	pass

func _on_bt_game_pressed():
	get_parent().playNewGame()

func _on_bt_settings_pressed():
	tf_logo.set_hidden(true)
	cc_for_bt.set_hidden(true)
	cc_for_tc.set_hidden(false)

func _on_bt_exit_pressed():
	get_tree().quit()
	
	
############################################
# SETTINGS CONTROL
############################################
func _on_bt_cancel_pressed():
	tf_logo.set_hidden(false)
	cc_for_bt.set_hidden(false)
	cc_for_tc.set_hidden(true)

func _on_bt_ok_pressed():
	tf_logo.set_hidden(false)
	cc_for_bt.set_hidden(false)
	cc_for_tc.set_hidden(true)