extends Node2D

var ground
var trees
var player
var zombie = preload("res://Assets/Scenes/zombie.scn")
var progressBar 
var PBvalue = 0

var maxTrees = 2048

var step = 0
var size = Rect2(-50,-50,50,50)
var x
var y
var w
var h

var alpha = 1.0

var pp = preload ("res://Assets/Scenes/gg.scn")

func _ready():
	
	x = size.pos.x
	y = size.pos.y
	w = size.size.width
	h = size.size.height
	randomize()
	ground = get_node("Navigation2D/map")
	trees = get_node("Navigation2D/map 2")
	player = get_node("player")
	progressBar = get_node("ui/ProgressBar")
	progressBar.set_max(((abs(x))+w)*(abs(y)+h))
	set_process(true)
	ground.clear()
	trees.clear()
	OS.set_target_fps(1800)

func _process(delta):
	if step == 0:
		x += 1
		ground.set_cell(x,y,0)
		if (x == size.size.width):
			x = size.pos.x
			y += 1
		if (y == size.size.height):
			step +=1
			PBvalue = 0
			x = size.pos.x
			y = size.pos.y
			progressBar.set_max(maxTrees)
			progressBar.set_val(PBvalue)
		else:
			PBvalue += 1
	
	if step == 1:
		if PBvalue != maxTrees:
			var pos = Vector2(randi()%int((abs(x))+w)+x+1,randi()%int(abs(y)+h)+y+1)
			ground.set_cellv(pos,-1)
			trees.set_cellv(pos,randi()%8+1,randi()%2,randi()%2,randi()%2)
			PBvalue += 1
		else: 
			progressBar.hide()
			var p = pp.instance()
			p.set_name("player")
			add_child(p)
			step += 1
	if step == 2:
		get_node("ui/bg").set_modulate(Color(1,1,1,alpha))
		get_node("ui/nameLevel").set_modulate(Color(1,1,1,alpha))
		alpha -= delta
		if alpha <= 0:
			step += 1
	if step == 3:
		get_node("StreamPlayer").play()
		get_node("ui/gun").show()
		OS.set_target_fps(30)
		step += 1
	progressBar.set_val(PBvalue)

#var SIZE_RECT = 10
#
#
#
#var cw = Color (0.7,0.7,1)
#var cr = Color (0.8,0.8,0)
#var cg = Color (0.1,0.9,0.1)
#var cb = Color (0,0,0.8)
#var cc = Color (0,0.7,0)
#var tr = Color (0.3,1,0.3)
#
#
#var colors = [cw,cr,cg,cb,cc,tr]
#			
#var variant = {cw:[0,2,4],
#				cr:[1,2],
#				cg:[0,1,2,3,4],
#				cb:[2,3,4,5],
#				cc:[0,2,3,4,5],
#				tr:[1,3,4,5]
#				}
#var m = []
#var n=64
#func _draw():
#	var color=0
#	randomize()
#	for i in range (0,n):
#		var t = []
#		for j in range (0,n):
#			t.append(-1)
#		m.append(t)
#			
#	for i in range (0,n):
#		for j in range (0,n):
#			if i==0 and j==0:
#				color = randi() % colors.size() # 0-4
#			else:
#
#				var dir = [[1,0],[-1,0], [0,-1],[0,1],
#				          [1,1],[-1,-1],[-1,1],[1,-1]]
#				var cur_variant = variant[colors[color]] #1->cr->[1,2] #color = old color
#
#				var ok=0
#				while ok<8:
#					color = cur_variant[randi() % cur_variant.size()]
#
#					for d_xy in dir:
#						var i2 = d_xy[0]+i
#						var j2 = d_xy[1]+j
#						if not(i2 in [-1,n]) and not(j2 in [-1,n]):
#							if m[i2][j2] in variant[colors[color]]+[-1]:
#								ok+=1
#							else:
#								ok=0
#								break
#						else:
#							ok+=1
#			m[i][j] = color
#	for xxx in range(10):		
#		for i in range (0, n):
#			for j in range (0, n):
#				var neigbor_points = [[[1,0], [-1,0]], [[0,-1], [0,1]]]
#				for points in neigbor_points:
#					var vh = []
#					for point in points:
#						var i2 = i + point[0]
#						var j2 = j + point[1]
#						if not(i2 in [-1,n]) and not(j2 in [-1,n]):
#							vh.append(m[i2][j2])
#						else:
#							vh.append(-1)
#					if vh[0]==vh[1]:
#						m[i][j]=vh[0]
#					
#
#				
#	for i in range (0, n):
#		for j in range (0, n):	
#			draw_rect(Rect2(Vector2(i*SIZE_RECT,j*SIZE_RECT),Vector2(SIZE_RECT,SIZE_RECT)),colors[m[i][j]])
#
#func _on_Button_pressed():
#	update()
