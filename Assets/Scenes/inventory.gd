extends TabContainer

var dropping = false
var item 
var icon

func _ready():
	set_process(true)
	for i in range (0,5):
		for j in range (1,9):
			get_node("Inventory/"+str(i)+"-"+str(j)).set_script(load("res://Assets/Scripts/button_dnd.gd"))

func _process(delta):
	if (dropping and not Input.is_mouse_button_pressed(BUTTON_LEFT)):
#		get_node("Inventory/"+str(item)).set_button_icon(icon)
		dropping = false