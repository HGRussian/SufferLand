extends Area2D

var count
var name
var ID

var colliding = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if (Input.is_action_pressed("pickup") and colliding):
		get_parent().get_parent().get_node("UI/Inventory").add_item(self)

func _on_Node2D_body_enter( body ):
	get_node("UI/label").set_text(name+"("+str(count)+")")
	get_node("UI/label").show()
	colliding = true
	


func _on_Node2D_body_exit( body ):
	get_node("UI/label").hide()
	colliding = false
