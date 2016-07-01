
extends Control
onready var tf_logo = get_node('cl/tf_logo')
onready var cc_for_bt = get_node('cl/cc_for_bt')
onready var cc_for_tc = get_node('cl/cc_for_tc')
onready var tc_settings = cc_for_tc.get_node('vbc/tc_settings')
onready var sound = get_node("SamplePlayer")

func _ready():
	pass

func _on_bt_game_pressed():
	sound.play("SLCLICK")
	get_parent().playNewGame()

func _on_bt_settings_pressed():
	sound.play("SLCLICK")
	tf_logo.set_hidden(true)
	cc_for_bt.set_hidden(true)
	cc_for_tc.set_hidden(false)

func _on_bt_exit_pressed():
	sound.play("SLCLICK")
	get_tree().quit()
	
	
############################################
# SETTINGS CONTROL
############################################
func _on_bt_cancel_pressed():
	sound.play("SLCLICK")
	tf_logo.set_hidden(false)
	cc_for_bt.set_hidden(false)
	cc_for_tc.set_hidden(true)

func _on_bt_ok_pressed():
	sound.play("SLCLICK")
	tf_logo.set_hidden(false)
	cc_for_bt.set_hidden(false)
	cc_for_tc.set_hidden(true)


func _on_hsl_lvlMusic_value_changed( value ):
	var lb_music = tc_settings.get_node('Sound/lb_music')
	lb_music.set_text("Music: " + str(value))
	get_parent().sound_level = value
	print(get_parent().sound_level)

#####################
#HOVER
#####################


func _on_bt_game_mouse_enter():
	sound.play("SLCLICK2")


func _on_bt_settings_mouse_enter():
	sound.play("SLCLICK2")


func _on_bt_exit_mouse_enter():
	sound.play("SLCLICK2")


func _on_bt_ok_mouse_enter():
	sound.play("SLCLICK2")


func _on_bt_cancel_mouse_enter():
	sound.play("SLCLICK2")

