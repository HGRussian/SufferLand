
extends Node2D
onready var loadScene = load('Assets/Scenes/load.scn').instance()
onready var worldGen = get_node("worldGen/grnd") 
onready var gg = get_node("player")

#UI
onready var progressBar = loadScene.get_node("cl/tpb_load")
onready var lvlSplash = loadScene.get_node("cl/tf_nameLevel")
#onready var transistion = get_node("ui/transistion")


var level = 0
var levelSize = [2048]
var levelBrush = [8]
var levelTrees = [32]
var levelRocks = [32]

var genStarted = false
var genEnded = false

func _ready():
	get_node(".").add_child(loadScene)
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
			progressBar.set_hidden(true)
			lvlSplash.set_hidden(true)
			#transistion.play("end")
			genEnded = true
			