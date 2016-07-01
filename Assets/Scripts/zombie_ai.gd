
extends RigidBody2D

onready var sprite = get_node("Body")
onready var player = get_node("../../player")
onready var ray = get_node("Body/ray")
onready var visor = get_node("Body/visor")
onready var anim = get_node("AnimationPlayer")
var maxDamage = 2
var damage = 0
export var activ = false
# points in the path
var points = []



func _ready():
	set_fixed_process(true)
	ray.add_exception_rid(get_rid())
	randomize()

func _fixed_process(delta):
	if activ == true:
		if not get_ded():
			var distance = get_pos().distance_to(player.get_global_pos())
			visor.set_cast_to(Vector2(0,distance))
			if ((ray.get_collider() != null) and (ray.get_collider().has_method("GO"))):
				ray.get_collider().GO()
		
		if (damage >= maxDamage):
			#get_node("../..").currentZombie -=1
			if anim.get_current_animation() != "ded":
				anim.play("ded")
				set_rot(deg2rad(randi()%360))
				get_node("CollisionShape2D").queue_free()
				#set_z(-9)
			if sprite.get_opacity() == 0:
				queue_free()

func add_damage(value):
	damage += value

func get_ded():
	if damage >= maxDamage:
		return(true)
	else:
		return(false)
#	
#
#func _draw():
#	# if there are points to draw
#	if points.size() > 1:
#		for p in range (0, points.size()-1):
#			if (points[p+1] != null):
#				draw_line(points[p] - get_global_pos(),points[p+1] - get_global_pos(), Color(1,0,0), 2) # we draw a circle (convert to global position first)

