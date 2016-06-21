extends Node2D

var SIZE_RECT = 10



var cw = Color (0.7,0.7,1)
var cr = Color (0.8,0.8,0)
var cg = Color (0.1,0.9,0.1)
var cb = Color (0,0,0.8)
var cc = Color (0,0.7,0)
var tr = Color (0.3,1,0.3)


var colors = [cw,cr,cg,cb,cc,tr]
			
var variant = {cw:[0,2,4],
				cr:[1,2],
				cg:[0,1,2,3,4],
				cb:[2,3,4,5],
				cc:[0,2,3,4,5],
				tr:[1,3,4,5]
				}
var m = []
var n=64
func _draw():
	var color=0
	randomize()
	for i in range (0,n):
		var t = []
		for j in range (0,n):
			t.append(-1)
		m.append(t)
			
	for i in range (0,n):
		for j in range (0,n):
			if i==0 and j==0:
				color = randi() % colors.size() # 0-4
			else:

				var dir = [[1,0],[-1,0], [0,-1],[0,1],
				          [1,1],[-1,-1],[-1,1],[1,-1]]
				var cur_variant = variant[colors[color]] #1->cr->[1,2] #color = old color

				var ok=0
				while ok<8:
					color = cur_variant[randi() % cur_variant.size()]

					for d_xy in dir:
						var i2 = d_xy[0]+i
						var j2 = d_xy[1]+j
						if not(i2 in [-1,n]) and not(j2 in [-1,n]):
							if m[i2][j2] in variant[colors[color]]+[-1]:
								ok+=1
							else:
								ok=0
								break
						else:
							ok+=1
			m[i][j] = color
	for xxx in range(10):		
		for i in range (0, n):
			for j in range (0, n):
				var neigbor_points = [[[1,0], [-1,0]], [[0,-1], [0,1]]]
				for points in neigbor_points:
					var vh = []
					for point in points:
						var i2 = i + point[0]
						var j2 = j + point[1]
						if not(i2 in [-1,n]) and not(j2 in [-1,n]):
							vh.append(m[i2][j2])
						else:
							vh.append(-1)
					if vh[0]==vh[1]:
						m[i][j]=vh[0]
					

				
	for i in range (0, n):
		for j in range (0, n):	
			draw_rect(Rect2(Vector2(i*SIZE_RECT,j*SIZE_RECT),Vector2(SIZE_RECT,SIZE_RECT)),colors[m[i][j]])

func _on_Button_pressed():
	update()
