
extends Node2D
onready var splash = load('Assets/Scenes/splash.scn').instance()
onready var worldGen = get_node("worldGen/grnd") 
onready var gg = get_node("player")
onready var npc_node = get_node("NPC")
#UI
onready var progressBar = splash.get_node("cl/tpb_load")
onready var lvlSplash = splash.get_node("cl/tf_nameLevel")
onready var sp_noise = splash.get_node("sp_noise")
onready var sp_gameSound = get_node("sp_gameSound")

var cur_n_lvl = -1
var nextLvl = false
var levelSize = [2048]
var levelBrush = [8]
var levelTrees = [32]
var levelRocks = [32]

var genStarted = false
var genEnded = false

func nextLevel():
	nextLvl = true

func hide_splash():
	progressBar.set_hidden(true)
	lvlSplash.set_hidden(true)
	sp_noise.stop()
	sp_gameSound.play()
	
func show_splash():
	var zone = 1
	var tex = load('Assets/Art/splash/z'+ str(zone) + 'p' + str(cur_n_lvl + 1) + '.png')
	lvlSplash.set_texture(tex)
	progressBar.set_hidden(false)
	lvlSplash.set_hidden(false)
	sp_noise.play()
	sp_gameSound.stop()

func _ready():
	nextLevel()
	get_node(".").add_child(splash)
	set_process(true)

func level():
	if genStarted != true:
		cur_n_lvl = cur_n_lvl + 1
		show_splash()
		worldGen.size = levelSize[cur_n_lvl]
		worldGen.brush = levelBrush[cur_n_lvl]
		worldGen.trees = levelTrees[cur_n_lvl]
		worldGen.rocks = levelRocks[cur_n_lvl]
		worldGen.gen(cur_n_lvl)
		genStarted = true
	if genEnded != true:
		if worldGen.get_step() == 6:
			hide_splash()
			gg.activ = true
			for npc in npc_node.get_children():
				npc.activ=true
			genEnded = true	
			nextLvl = false
			print('cur_lvl: ',cur_n_lvl)
				
func _process(delta):
	progressBar.set_val(worldGen.get_progress())
	if nextLvl==true:
		gg.activ = false
		for npc in npc_node.get_children():
			npc.activ=false
		var genStarted = false
		var genEnded = false
		level()

