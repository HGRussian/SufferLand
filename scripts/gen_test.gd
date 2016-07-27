
extends Node2D

var step
var x
var y
var dir
var radius = 8
var len = 256
var exit_point = Vector2()
var end_point = Vector2()
onready var tiles = get_node("tiles")

onready var terrain = get_node("terrain")
onready var props = get_node("props")

func _ready():
	randomize() 
	set_rot(randi()%360)
	_gen()

func _drawCircle(x,y):
	var r2 = radius*radius
	for x1 in range(-radius,radius):
		var y1 = sqrt(r2-x1*x1)+0.5
		tiles.set_cell(x+x1,y+y1,0)
		tiles.set_cell(x+x1,y-y1,0)

func _gen():
	randomize()
	step = 0
	if step == 0:
		#generating start area
		x = 0
		y = 0
		dir = 0
		while tiles.get_used_cells().size() < 2048:
			dir=randi()%4
			if dir == 0: 
				if x < 64:
					x+=1
				else:
					x+=-1
			if dir == 1: 
				if x > -64:
					x+=-1
				else:
					x+=1
			if dir == 2: 
				if y < 64:
					y+=1
				else:
					y+=-1
			if dir == 3: 
				if y > -64:
					y+=-1
				else:
					y+=1
			#drawcircle
			_drawCircle(x,y)
		#find bottom point
		var j_bottom = 0
		var x_last = 0
		var mid_x = 0
		for i in range(-64,64):
			for j in range(-64,64):
				if tiles.get_cell(i,j) == 0:
					if j>j_bottom:
						j_bottom=j
						x_last = i
		for i in range(x_last,64):
			if tiles.get_cell(i,j_bottom) == 0:
				mid_x+=1
		x = (x_last + x_last+mid_x)/2
		exit_point = Vector2(x,j_bottom)
		step+=1
	if step == 1:
		#gen_line
		radius+=-4
		end_point = exit_point + Vector2(0,len)
		for iter in range(0,4):
			x = exit_point.x
			y = exit_point.y
			dir = 0
			while y != end_point.y:
				dir = randi()%4
				if dir == 0:
					y+=1
				if dir == 1:
					x+=1
				if dir == 2:
					x+=-1
				_drawCircle(x,y)
				var chance = int(end_point.y-y)*4
				if chance > 32:
					if randi()%chance < 16:
						if x>end_point.x:
							x+=-1
							_drawCircle(x,y)
						if x<end_point.x:
							x+=1
							_drawCircle(x,y)
				else:
					if x>end_point.x:
						x+=-1
						_drawCircle(x,y)
					if x<end_point.x:
						x+=1
						_drawCircle(x,y)
		step+=1
	if step == 2:
		x = end_point.x
		y = end_point.y
		dir = 0
		var max_used = tiles.get_used_cells().size() + 1024
		while tiles.get_used_cells().size() < max_used:
			dir=randi()%4
			if dir == 0: 
				if x < end_point.x+32:
					x+=1
				else:
					x+=-1
			if dir == 1: 
				if x > end_point.x-32:
					x+=-1
				else:
					x+=1
			if dir == 2: 
				if y < end_point.y+64:
					y+=1
				else:
					y+=-1
			if dir == 3: 
				if y > end_point.y-32:
					y+=-1
				else:
					y+=1
			#drawcircle
			_drawCircle(x,y)
		step+=1
	if step == 3:
		#smooth
		for iter in range(0,2):
			for i in range(-64,64):
				for j in range(-64,96+len):
					if tiles.get_cell(i,j) == -1:
						var clean = 0
						if tiles.get_cell(i+1,j) == 0:
							clean+=1
						if tiles.get_cell(i-1,j) == 0:
							clean+=1
						if tiles.get_cell(i,j+1) == 0:
							clean+=1
						if tiles.get_cell(i,j-1) == 0:
							clean+=1
						if clean > 2:
							tiles.set_cell(i,j,0)
		step+=1
	if step == 4:
		for i in range(-128,128):
			for j in range(-96,128+len):
				if tiles.get_cell(i,j) == -1:
					if tiles.get_cell(i+1,j) == 0 or tiles.get_cell(i-1,j) == 0 or tiles.get_cell(i,j-1) == 0 or tiles.get_cell(i,j+1) == 0:
						tiles.set_cell(i,j,1)
		step+=1
	if step == 5:
		for i in range(-128,128):
			for j in range(-96,128+len):
				if tiles.get_cell(i,j) == 0:
					terrain.set_cell(i,j,randi()%2,randi()%2,randi()%2,randi()%2)
					if randi()%128 == 0: #tire
						var tire = load("res://scn/_props/tire.scn").instance()
						tire.set_rot(deg2rad(randi()%360))
						tire.set_pos(terrain.map_to_world(Vector2(i,j)))
						get_node("props").add_child(tire)
					elif randi()%128 == 0: #car
						var car = load("res://scn/_props/car.scn").instance()
						car.set_rot(deg2rad(randi()%360))
						car.set_pos(terrain.map_to_world(Vector2(i,j)))
						get_node("props").add_child(car)
					elif randi()%64 == 0: #trash
						var type = randi()%4
						var trash = load("res://scn/_props/trash"+str(type+1)+".scn").instance()
						trash.set_rot(deg2rad(randi()%360))
						trash.set_pos(terrain.map_to_world(Vector2(i,j)))
						trash.get_node("rubbish").set_modulate(Color(clamp(randf(),0.5,1),clamp(randf(),0.5,1),clamp(randf(),0.5,1)))
						get_node("props").add_child(trash)