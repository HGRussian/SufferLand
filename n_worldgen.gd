
extends TileMap

export var size = 2048
export var brush = 8

var progress = 0
var step = -1

var x = 0
var y = 0
var dir = 0
var tiles_count = 0

func _ready():
	set_process(true)
	gen()

func _process(delta):
	if step == 0:
		if tiles_count < size:
			dir = randi()%4
			if dir == 0:
				x+=1
			if dir == 1:
				y+=1
			if dir == 2:
				x+=-1
			if dir == 3:
				y+=-1
			for i in range(x-brush/2,x+brush/2):
				for j in range(y-brush/2,y+brush/2):
					if get_cell(i,j) == -1:
						tiles_count+=1
					set_cell(i,j,0)
		else:
			step+=1
	if step == 1:
		for i in range(-size/16,size/16):
			for j in range(-size/16,size/16):
				var clean = 0
				if get_cell(i,j) == -1:
					if get_cell(i+1,j) != -1:
						clean+=1
					if get_cell(i-1,j) != -1:
						clean+=1
					if get_cell(i,j+1) != -1:
						clean+=1
					if get_cell(i,j-1) != -1:
						clean+=1
				if clean > 2:
					for m in range(i-brush/2,i+brush/2):
						for n in range(j-brush/2,j+brush/2):
							set_cell(m,n,0)
		get_node("../fog").set_emission_points(get_used_cells())
		step+=1
#	if step == 2:
#		for i in range(-size/16,size/16):
#			for j in range(-size/16,size/16):
#				if get_cell(i,j) == 0:

func gen():
	clear()
	randomize()
	x = 0
	y = 0
	step = 0