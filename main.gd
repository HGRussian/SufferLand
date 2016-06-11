extends Node2D
#
#onready var map = get_node("map")
#var sizeGen = 128
#var chunk = Vector2(0,0)
#var maxTrees = 1000
#var maxRocks = 1000
#
#var trees = [11, 13, 15]
#var rocks = [3, 5, 7, 9]
#
#func _ready ():
#	
#	randomize()
#	for i in range (-sizeGen,sizeGen):
#		for j in range (-sizeGen,sizeGen):
#			map.set_cell(i,j,0)
#	var p = Vector2 (randi()%sizeGen-sizeGen/2, randi()%sizeGen-sizeGen/2)
#	while (map.get_cell(p.x,p.y) != -1):
#		map.set_cell(p.x,p.y,8)
#		p += Vector2(randi()%2-randi()%2,randi()%2-randi()%2)
#	var p = Vector2 (randi()%sizeGen-sizeGen/2, randi()%sizeGen-sizeGen/2)
#	while (map.get_cell(p.x,p.y) != -1):
#		map.set_cell(p.x,p.y,8)
#		p += Vector2(randi()%2-randi()%2,randi()%2-randi()%2)
#		
#	for i in range (-sizeGen+1,sizeGen-1):
#		for j in range (-sizeGen+1,sizeGen-1):
#			if (map.get_cell(i,j-1) == map.get_cell(i,j+1)):
#				map.set_cell(i,j,map.get_cell(i,j-1))
#	for j in range (-sizeGen+1,sizeGen-1):
#		for i in range (-sizeGen+1,sizeGen-1):
#			if (map.get_cell(i-1,j) == map.get_cell(i+1,j)):
#				map.set_cell(i,j,map.get_cell(i-1,j))
#	
#	for i in range (-sizeGen,sizeGen):
#		for j in range (-sizeGen,sizeGen):
#			if (map.get_cell(i,j) == 8):
#				if (map.get_cell(i,j+1) == 0):
#					if (map.get_cell(i-1,j) == 0):
#						map.set_cell(i-1,j+1, 4)
#					if (map.get_cell(i+1,j) == 0):
#						map.set_cell(i+1,j+1, 4, true)
#					map.set_cell(i,j+1, 1) 
#				if (map.get_cell(i,j-1) == 0):
#					if (map.get_cell(i-1,j) == 0):
#						map.set_cell(i-1,j-1, 4 , false, true)
#					if (map.get_cell(i+1,j) == 0):
#						map.set_cell(i+1,j-1, 4, true, true)
#					map.set_cell(i,j-1, 1, false, true) 
#				if (map.get_cell(i+1,j) == 0):
#					map.set_cell(i+1,j, 1, false, false, true) 
#				elif (map.get_cell(i-1,j) == 0):
#					map.set_cell(i-1,j, 1, true, false, true)
#	var tr = 0
#	while (tr != maxTrees):
#		var x = randi()%sizeGen*2-sizeGen
#		var y = randi()%sizeGen*2-sizeGen
#		if (map.get_cell(x,y) == 0):
#			map.set_cell(x,y,trees[randi()%3],randi()%2,randi()%2,randi()%2)
#			tr += 1
#	tr = 0
#	while (tr < maxRocks):
#		var x = randi()%sizeGen*2-sizeGen
#		var y = randi()%sizeGen*2-sizeGen
#		if (map.get_cell(x,y) == 0):
#			map.set_cell(x,y,rocks[randi()%4],randi()%2,randi()%2,randi()%2)
#			tr += 1
#	Input.set_custom_mouse_cursor(load("res://Assets/Art/curs.png"),Vector2(11,11))
#	
#	var instPLayer = false
#	while (!instPLayer):
#		var x = randi()%sizeGen-sizeGen/2
#		var y = randi()%sizeGen-sizeGen/2
#		if (map.get_cell(x,y) == 0):
#			var player = load("res://Assets/Scenes/gg.scn").instance()
#			player.set_pos (map.map_to_world(Vector2(x,y)))
#			player.set_name ("player")
#			add_child(player)
#			instPLayer = true