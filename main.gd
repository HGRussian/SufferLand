extends Node2D

var ground
var trees
var player
var zombie = preload("res://Assets/Scenes/zombie.scn")
var progressBar 
var info
var PBvalue = 0

var maxTrees = 1024

var step = 0
var size = Rect2(-64,-64,64,64)
var x
var y
var w
var h
var map = {}
var chunk_size = Vector2(8,8)
var current_chunk = Vector2(0,0)
var chunk_checker

var alpha = 0.0
var startLoad = false
var pp = preload ("res://Assets/Scenes/gg.scn")
var maxZombie = 16
var currentZombie = 0
var zombieScore = 0
var dir = 		[
				Vector2(1,1),
				Vector2(-1,1),
				Vector2(1,-1),
				Vector2(-1,-1)
				]

func _ready():
	seed(1)
	x = size.pos.x
	y = size.pos.y
	w = size.size.width
	h = size.size.height
	randomize()
	ground = get_node("Navigation2D/map")
	trees = get_node("Navigation2D/map 2")
	
	progressBar = get_node("ui/ProgressBar")
	info = get_node("ui/info")
	chunk_checker = get_node("chunks")
	progressBar.set_max(((abs(x))+w)*(abs(y)+h))
	set_process(true)
	ground.clear()
	trees.clear()
	OS.set_target_fps(30)

func _process(delta):
	if startLoad:
		if step == 0:
			for i in range (0,128):
				info.set_text("Gen ground. Step: 1, added: "+str(PBvalue))
				map[Vector2(x,y)] = 0
				if x == size.pos.x:
					map[Vector2(x,y)] = 9
				if (y == size.size.height):
					map[Vector2(x,y)] = 9
				if (y == size.pos.height):
					map[Vector2(x,y)] = 9
				if (x == size.size.width):
					x = size.pos.x
					map[Vector2(x,y)] = 9
					y += 1
				if (y > size.size.height):
					step +=1
					PBvalue = 0
					x = size.pos.x
					y = size.pos.y
					progressBar.set_max(maxTrees)
					progressBar.set_val(PBvalue)
					break
				else:
					PBvalue += 1
				x += 1
			
		
		if step == 1:
			for i in range (0,32):
				info.set_text("Gen trees. Step: 2, added: "+str(PBvalue))
				if PBvalue != maxTrees:
					var pos = Vector2(randi()%int((abs(x))+w)+x+1,randi()%int(abs(y)+h)+y+1)
					map[pos] = randi()%8+1
					PBvalue += 1
				else: 
					progressBar.hide()
					var p = pp.instance()
					p.set_name("player")
					add_child(p)
					player = get_node("player")
					step += 1
					break
		if step == 2:
			get_node("ui/bg").set_modulate(Color(1,1,1,alpha))
			get_node("ui/nameLevel").set_modulate(Color(1,1,1,alpha))
			alpha -= delta*0.5
			if alpha <= 0:
				step += 1
		if step == 3:
			info.set_text(" ")
			get_node("StreamPlayer").play()
			get_node("ui/gun").show()
			step += 1
			
		if step == 4:
			for i in range (current_chunk.x-1,current_chunk.x+2):
				for j in range (current_chunk.y-1,current_chunk.y+2):
					for xc in range (0,chunk_size.x):
						for yc in range (0,chunk_size.y):
							var tile = Vector2(i,j)*chunk_size+Vector2(xc,yc)
							if map.has(tile):
								if map[tile] == 0:
									ground.set_cellv(tile,0)
								elif map[tile] == 9:
									ground.set_cellv(tile,1)
								else:
									trees.set_cellv(tile,map[tile])
			get_node("genTimerZombie").start()
			step += 1
		if step == 5:
			
			if (has_node("player") and (chunk_checker.world_to_map(player.get_pos()) != current_chunk)):
				ground.clear()
				trees.clear()
				for i in range (current_chunk.x-2,current_chunk.x+3):
					for j in range (current_chunk.y-2,current_chunk.y+3):
						for xc in range (0,chunk_size.x):
							for yc in range (0,chunk_size.y):
								var tile = Vector2(i,j)*chunk_size+Vector2(xc,yc)
								if map.has(tile):
									if map[tile] == 0:
										ground.set_cellv(tile,0)
									elif map[tile] == 9:
										ground.set_cellv(tile,1)
									else:
										trees.set_cellv(tile,map[tile])
				current_chunk = chunk_checker.world_to_map(player.get_pos())
		progressBar.set_val(PBvalue)
	else:
		get_node("ui/bg").set_modulate(Color(1,1,1,alpha))
		get_node("ui/nameLevel").set_modulate(Color(1,1,1,alpha))
		alpha += delta*0.5

func _on_Timer_timeout():
	startLoad = true
	progressBar.show()


func _on_genTimerZombie_timeout():
	if currentZombie < maxZombie:
		zombieScore += 1
		var z = zombie.instance()
		z.set_pos(get_node("player").get_pos()+Vector2((randi()%64+128)*dir[randi()%4].x,(randi()%64+128)*dir[randi()%4].y))
		z.set_name("zombie"+str(zombieScore))
		get_node("zombie").add_child(z)
