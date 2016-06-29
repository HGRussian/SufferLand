
extends Node2D

onready var worldGen = get_node("world_gen/grnd") 
onready var gg = get_node("player")

#ui
onready var progressBar = get_node("ui/ProgressBar")
onready var transistion = get_node("ui/transistion")

var level = 0
var levelSize = [2048]
var levelBrush = [8]
var levelTrees = [32]
var levelRocks = [32]

var genStarted = false
var genEnded = false

func _ready():
	set_process(true)

func _process(delta):
	if genStarted != true:
		worldGen.gen()
		genStarted = true
	progressBar.set_val(worldGen.get_progress())
	if genEnded != true:
		if worldGen.get_step() == 6:
			transistion.play("end")
			genEnded = true
			