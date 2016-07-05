
extends RigidBody2D

onready var sprite = get_node("Body")
onready var player = get_node("../../player")
onready var ray = get_node("Body/ray")
onready var walker = get_node("Body/Position2D")
onready var anim = get_node("AnimationPlayer")
var maxDamage = 2
var damage = 0
var curpoint = 0
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
			points = get_node("../../worldGen").get_simple_path(get_global_pos(), player.get_global_pos(), true)
			if points.size() > 1:
				look_at(points[1])
				var impulse = (points[1] - get_global_pos()).normalized()
				apply_impulse(Vector2(), impulse * 1000 * delta) 
			var distance = get_global_pos().distance_to(player.get_global_pos())
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