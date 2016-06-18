
extends Node2D

var count = 0
var sprite = preload ("res://Assets/Scenes/Sprite.scn")

func _ready():
	set_process(true)

func _process(delta):
	while count < 100000:
		var s = sprite.instance()
		s.set_pos(Vector2(count,16))
		add_child(s)
		print (str(OS.get_frames_per_second())+"  ||  "+str(count))
		count += 1
		var s = sprite.instance()
		s.set_pos(Vector2(count,32))
		add_child(s)
		print (str(OS.get_frames_per_second())+"  ||  "+str(count))
		count += 1
		var s = sprite.instance()
		s.set_pos(Vector2(count,64))
		add_child(s)
		print (str(OS.get_frames_per_second())+"  ||  "+str(count))
		count += 1
		var s = sprite.instance()
		s.set_pos(Vector2(count,96))
		add_child(s)
		print (str(OS.get_frames_per_second())+"  ||  "+str(count))
		count += 1
		var s = sprite.instance()
		s.set_pos(Vector2(count,128))
		add_child(s)
		print (str(OS.get_frames_per_second())+"  ||  "+str(count))
		count += 1


