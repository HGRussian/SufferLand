
extends Node2D
onready var splash = load('Assets/Scenes/load.scn').instance()
onready var worldGen = get_node("worldGen/grnd") 
onready var gg = get_node("player")

#UI
onready var progressBar = splash.get_node("cl/tpb_load")
onready var lvlSplash = splash.get_node("cl/tf_nameLevel")
onready var sp_noise = splash.get_node("sp_noise")
onready var sp_gameSound = get_node("sp_gameSound")

func hide_splash():
	progressBar.set_hidden(true)
	lvlSplash.set_hidden(true)
	sp_noise.stop()
	sp_gameSound.play()
	
func show_splash():
	progressBar.set_hidden(false)
	lvlSplash.set_hidden(false)
	sp_noise.play()
	sp_gameSound.stop()
	
var level = 0
var levelSize = [2048]
var levelBrush = [8]
var levelTrees = [32]
var levelRocks = [32]

var genStarted = false
var genEnded = false

func _ready():
	get_node(".").add_child(splash)
	set_process(true)

func _process(delta):
	
	if genStarted != true:
		worldGen.size = levelSize[level]
		worldGen.brush = levelBrush[level]
		worldGen.trees = levelTrees[level]
		worldGen.rocks = levelRocks[level]
		worldGen.gen()
		genStarted = true
	progressBar.set_val(worldGen.get_progress())
	if genEnded != true:
		if worldGen.get_step() == 6:
			hide_splash()
			gg.activ=true
			genEnded = true
			