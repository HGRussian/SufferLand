
extends Node2D

func _ready():
	pass

func _on_bt_stopZombie_pressed():
	var zombies = get_parent().get_node('Zombie')
	for zombie in zombies.get_children():
		zombie.activ=false

func _on_bt_runZombie_pressed():
	var zombies = get_parent().get_node('Zombie')
	for zombie in zombies.get_children():
		zombie.activ=true