extends TileMap

var size
var count

func _ready():
	randomize()
	size = Vector2(randi()%12+2,randi()%12+2)
	count = randi()%14+2
	var fin = 0
	while (fin < count):
		set_cell(randi()%int(size.x),randi()%int(size.y),randi()%24,randi()%2,randi()%2,randi()%2)
		fin += 1

