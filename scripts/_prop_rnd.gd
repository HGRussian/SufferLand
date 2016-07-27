
extends AnimatedSprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	randomize()
	set_frame(randi()%get_sprite_frames().get_frame_count("default"))
	set_modulate(Color(clamp(randf(),0.8,1),clamp(randf(),0.8,1),clamp(randf(),0.8,1)))
