extends TabContainer

var dropping = false
var count
var ID
var tooltip
var current_fastCell = 2
var old_fastCell = 1

var pressFastButton = false

func _ready():
	
	set_process(true)
	for i in range (0,5):
		for j in range (1,9):
			var l = Label.new()
			l.set_scale(Vector2(0.5,0.5))
			l.set_name("count")
			get_node("Inventory/"+str(i)+"-"+str(j)).add_child(l)
			get_node("Inventory/"+str(i)+"-"+str(j)).set_script(load("res://Assets/Scripts/button_dnd.gd"))
	for i in range (1,9):
		var l = Label.new()
		l.set_scale(Vector2(0.5,0.5))
		l.set_name("count")
		get_parent().get_node("fastPanel/0-"+str(i)).add_child(l)
	
func _process(delta):
	if (dropping and not Input.is_mouse_button_pressed(BUTTON_LEFT)):
		dropping = false
		get_parent().get_parent().createItem(ID, get_parent().get_parent().get_node("player").get_global_pos()+Vector2(0,-20),count)
	for i in range (1,9):
		if (str(get_node("Inventory/0-"+str(i)).get_node("count").get_text()) != get_parent().get_node("fastPanel/0-"+str(i)).get_node("count").get_text()):
			get_parent().get_node("fastPanel/0-"+str(i)).get_node("count").set_text (str(get_node("Inventory/0-"+str(i)).get_node("count").get_text()))
		if (get_parent().get_node("fastPanel/0-"+str(i)).get_button_icon() != get_node("Inventory/0-"+str(i)).get_button_icon()):
			get_parent().get_node("fastPanel/0-"+str(i)).set_button_icon(get_node("Inventory/0-"+str(i)).get_button_icon())
	
	if (current_fastCell != old_fastCell):
		get_parent().get_node("fastPanel/0-"+str(old_fastCell)).set_flat(true)
		get_parent().get_node("fastPanel/0-"+str(current_fastCell)).set_flat(false)
		current_fastCell = old_fastCell
		
	if (Input.is_key_pressed(KEY_1) and old_fastCell != 1):
		old_fastCell = 1
	elif (Input.is_key_pressed(KEY_2) and old_fastCell != 2):
		old_fastCell = 2
	elif (Input.is_key_pressed(KEY_3) and old_fastCell != 3):
		old_fastCell = 3
	elif (Input.is_key_pressed(KEY_4) and old_fastCell != 4):
		old_fastCell = 4
	elif (Input.is_key_pressed(KEY_5) and old_fastCell != 5):
		old_fastCell = 5
	elif (Input.is_key_pressed(KEY_6) and old_fastCell != 6):
		old_fastCell = 6
	elif (Input.is_key_pressed(KEY_7) and old_fastCell != 7):
		old_fastCell = 7
	elif (Input.is_key_pressed(KEY_8) and old_fastCell != 8):
		old_fastCell = 8

func add_item(obj):
	var end = false
	for i in range (0,5):
		if (not end):
			for j in range (1,9):
				if (not end):
					if get_node("Inventory/"+str(i)+"-"+str(j)).get_button_icon() == null:
						end = true
						get_node("Inventory/"+str(i)+"-"+str(j)).set_button_icon(load("res://Assets/Art/Props/"+obj.name+".png"))
						get_node("Inventory/"+str(i)+"-"+str(j)).set_tooltip(obj.name)
						get_node("Inventory/"+str(i)+"-"+str(j)+"/count").set_text(str(obj.count))
						obj.queue_free()
					elif get_node("Inventory/"+str(i)+"-"+str(j)).get_button_icon() == load("res://Assets/Art/Props/"+obj.name+".png"):
						pass
	