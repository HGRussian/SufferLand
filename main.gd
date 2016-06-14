extends Node2D

onready var map = get_node("map")
var size = 256
var ground_tile = [0,6,12,18,24,30,35,40]
var water_tile = [45]

var riv_brigde_max = 4
var riv_border_tile = [3,9,15,21]
var riv_corner_tile = [10,16,22,28]
var riv_single_tile = [44]
var riv_single_corner_tile = [39]
var riv_single_border_tile = [47]
var riv_bridge_tile = [5,11,17]

func _ready():
	randomize()
	map.clear()
	_gen()
	

func _gen():
	map.clear()
	#ground
	for x in range(0-size/2,size/2):
		for y in range(0-size/2,size/2):
			map.set_cell(x,y,ground_tile[0])
	#rivers
	var rivers = size/32
	var riv_count = 0
	while riv_count < rivers:
		riv_count+=1
		var riv_size = size+randi()%size
		var sx = randi()%size-size/2
		var sy = randi()%size-size/2
		var tile_count = 0
		var dir = 0
		var riv_dir = randi()%4
		var brigde_count = 0
		while tile_count < riv_size:
			if riv_dir == 0:
				sx+=1
			if riv_dir == 1:
				sx+=-1
			if riv_dir == 2:
				sy+=1
			if riv_dir == 3:
				sy+=-1
			for x in range(sx-2,sx+2):
				for y in range(sy-2,sy+2):
					if map.get_cell(x,y) != riv_bridge_tile[0]:
						map.set_cell(x,y,water_tile[0])
			tile_count+=1
			dir = randi()%4
			if dir == 0:
				sx+=1
			if dir == 1:
				sx+=-1
			if dir == 2:
				sy+=1
			if dir == 3:
				sy+=-1
			for x in range(sx-randi()%3,sx+randi()%3):
				for y in range(sy-randi()%3,sy+randi()%3):
					if map.get_cell(x,y) != riv_bridge_tile[0]:
						map.set_cell(x,y,water_tile[0])
			tile_count+=1
			#brigdes
#			if brigde_count != riv_brigde_max:
#				if randi()%16 == 0:
#					brigde_count+=1
#					var bx = sx
#					var by = sy
#					if riv_dir < 2:
#						
#					if riv_dir > 1:
#						
	#riv_noise
	for x in range(0-size/2,size/2):
		for y in range(0-size/2,size/2):
			if map.get_cell(x,y) == water_tile[0]:
				if randi()%32 == 0:
					for qx in range(x-randi()%2,x+randi()%2):
						for qy in range(y-randi()%2,y+randi()%2):
							if map.get_cell(qx,qy) != riv_bridge_tile[0]:
								map.set_cell(qx,qy,ground_tile[0])
	#riv_borders
	for x in range(0-size/2,size/2):
		for y in range(0-size/2,size/2):
			if map.get_cell(x,y) != water_tile[0]:
				#borders
				if map.get_cell(x,y+1) == water_tile[0]:
					map.set_cell(x,y,riv_border_tile[randi()%riv_border_tile.size()],false,true,false)
				if map.get_cell(x,y-1) == water_tile[0]:
					map.set_cell(x,y,riv_border_tile[randi()%riv_border_tile.size()],false,false,false)
				if map.get_cell(x+1,y) == water_tile[0]:
					map.set_cell(x,y,riv_border_tile[randi()%riv_border_tile.size()],true,false,true)
				if map.get_cell(x-1,y) == water_tile[0]:
					map.set_cell(x,y,riv_border_tile[randi()%riv_border_tile.size()],false,false,true)
				#corners
				if map.get_cell(x+1,y) == water_tile[0]:
					if map.get_cell(x,y+1) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],true,true,false)
					if map.get_cell(x,y-1) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],true,false,false)
				
				if map.get_cell(x-1,y) == water_tile[0]:
					if map.get_cell(x,y+1) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],false,true,false)
					if map.get_cell(x,y-1) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],false,false,false)
				
				if map.get_cell(x,y+1) == water_tile[0]:
					if map.get_cell(x+1,y) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],true,true,false)
					if map.get_cell(x-1,y) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],false,true,false)
				
				if map.get_cell(x,y-1) == water_tile[0]:
					if map.get_cell(x+1,y) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],true,false,false)
					if map.get_cell(x-1,y) == water_tile[0]:
						map.set_cell(x,y,riv_corner_tile[randi()%riv_corner_tile.size()],false,false,false)
				#single_border
				if map.get_cell(x+1,y) == water_tile[0] and map.get_cell(x-1,y) == water_tile[0] and map.get_cell(x,y) != riv_bridge_tile[0]:
					map.set_cell(x,y,riv_single_border_tile[0],false,false,true)
				if map.get_cell(x,y-1) == water_tile[0] and map.get_cell(x,y+1) == water_tile[0] and map.get_cell(x,y) != riv_bridge_tile[0]:
					map.set_cell(x,y,riv_single_border_tile[0],false,false,false)
				#single_corner
				if map.get_cell(x+1,y) == water_tile[0]:
					if map.get_cell(x,y+1) == water_tile[0] and map.get_cell(x,y-1) == water_tile[0]:
						map.set_cell(x,y,riv_single_corner_tile[0],false,false,false)
				
				if map.get_cell(x-1,y) == water_tile[0]:
					if map.get_cell(x,y+1) == water_tile[0] and map.get_cell(x,y-1) == water_tile[0]:
						map.set_cell(x,y,riv_single_corner_tile[0],true,false,false)
				
				if map.get_cell(x,y-1) == water_tile[0]:
					if map.get_cell(x-1,y) == water_tile[0] and map.get_cell(x+1,y) == water_tile[0]:
						map.set_cell(x,y,riv_single_corner_tile[0],false,true,true)
				
				if map.get_cell(x,y+1) == water_tile[0]:
					if map.get_cell(x-1,y) == water_tile[0] and map.get_cell(x+1,y) == water_tile[0]:
						map.set_cell(x,y,riv_single_corner_tile[0],false,false,true)
				#single
				if map.get_cell(x+1,y) == water_tile[0] and map.get_cell(x-1,y) == water_tile[0] and map.get_cell(x,y-1) == water_tile[0] and map.get_cell(x,y+1) == water_tile[0]:
					map.set_cell(x,y,riv_single_tile[0],randi()%2,randi()%2,randi()%2)
	#grnd_noise
	for x in range(0-size/2,size/2):
		for y in range(0-size/2,size/2):
			if map.get_cell(x,y) == ground_tile[0]:
				if randi()%8 == 0:
					map.set_cell(x,y,ground_tile[randi()%ground_tile.size()],randi()%2,randi()%2,randi()%2)
			if map.get_cell(x,y) == riv_bridge_tile[0]:
				if map.is_cell_transposed(x,y):
					map.set_cell(x,y,riv_bridge_tile[randi()%riv_bridge_tile.size()],false,false,true)
				else:
					map.set_cell(x,y,riv_bridge_tile[randi()%riv_bridge_tile.size()])