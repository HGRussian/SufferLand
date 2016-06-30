extends TileMap

export var size = 2048
export var brush = 8
export var trees = 32
export var rocks = 32

var progress = 0.0
var step = -1

var x = 0
var y = 0
var dir = 0
var tiles_count = 0

var points = [] #emmision

func _ready():
	set_process(true)
	#gen()

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
					if randi()%8 == 1:
						tiles_count+=1
					set_cell(i,j,0)
			progress = 85-size/tiles_count
		else:
			for i in range(-8,8):
				for j in range(-8,8):
					set_cell(i,j,0)
			
			step+=1
	if step == 1:
		progress = 90
		for i in range(-size/64,size/64):
			for j in range(-size/64,size/64):
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
		step+=1
	if step == 2:
		progress = 0
		for i in range(-size/64,size/64):
			for j in range(-size/64,size/64):
				if get_cell(i,j) == -1:
					points.append(Vector2(i,j))
		progress = 0.75
		get_node("../fog").set_emission_points(points)
		get_node("../fog").set_emitting(true)
		get_node("../fog").pre_process(100)
		step+=1
	if step == 3:
		progress = 0
		for i in range(-size/64,size/64):
			for j in range(-size/64,size/64):
				if get_cell(i,j) == 0:
					if randi()%trees == 1:
						set_cell(i,j,1)
		step+=1
	if step == 4:
		progress = 0
		for i in range(-size/64,size/64):
			for j in range(-size/64,size/64):
				if get_cell(i,j) == 1:
					var tree = load("res://Assets/Scenes/trees/"+str(randi()%8+1)+".scn").instance()
					tree.set_pos(map_to_world(Vector2(i,j)))
					get_node("../trees").add_child(tree)
		step+=1
	if step == 5:
		progress = 0
		for i in range(-size/64,size/64):
			for j in range(-size/64,size/64):
				if get_cell(i,j) == 0:
					if randi()%rocks == 1:
						get_node("../rocks").set_cell(i,j,randi()%25,randi()%2,randi()%2,randi()%2)
		progress = 100
		step+=1

func gen():
	clear()
	randomize()
	x = 0
	y = 0
	step = 0

func get_progress():
	return(progress)

func get_step():
	return(step)