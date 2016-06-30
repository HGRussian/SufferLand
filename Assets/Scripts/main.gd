extends Node2D
onready var menu = load('Assets/Scenes/menu.scn').instance()
onready var game = load('Assets/Scenes/game.scn').instance()

class GameSettings:
	var sound_level = 10

func playNewGame():
	get_node('.').remove_child(menu)
	get_node(".").add_child(game)
	
func _ready():
	get_node(".").add_child(menu)
	
	


