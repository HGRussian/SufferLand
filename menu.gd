extends Node

var buttons = []
var distance
var current_button = 0

func _ready():
	buttons.append(get_node("UI/logo/b_play").get_pos())
	buttons.append(get_node("UI/logo/b_settings").get_pos())
	buttons.append(get_node("UI/logo/b_exit").get_pos())
	distance = get_node("UI/logo/point").get_pos() - buttons[0]
	get_node("UI/logo/point").set_pos(Vector2(buttons[0]+distance))
	set_process(true)

func _process(delta):
	if (Input.is_action_just_pressed("M_KEY_DOWN") and buttons.size()-1 > current_button ):
			current_button += 1
			get_node("UI/logo/point").set_pos(Vector2(buttons[current_button]+distance))
	elif (Input.is_action_just_pressed("M_KEY_UP") and 0 < current_button):
			current_button -= 1
			get_node("UI/logo/point").set_pos(Vector2(buttons[current_button]+distance))
	elif (Input.is_action_just_pressed("M_KEY_A")):
		if (current_button == 0):
			pass
		elif (current_button == 1):
			pass
		elif (current_button == 2):
			get_tree().quit()


func _on_Button_pressed():
	if (get_node("shader").is_visible()): 
		get_node("shader").hide()
	else:
		get_node("shader").show()
