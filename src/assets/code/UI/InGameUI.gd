extends CanvasLayer

onready var crosshair = $crosshair
onready var primary_gun_info = $gun_info1

func _enter_tree() -> void:
	$"/root/_InGame".register_node("UI", self)


func set_primary_ammo(current_ammo, max_ammo) -> void:
	crosshair.set_primary_ammo(current_ammo, max_ammo)
	primary_gun_info.text = "%02d/%02d" % [current_ammo, max_ammo]


func reloading_primary(max_ammo) -> void:
	crosshair.set_primary_ammo(max_ammo, max_ammo, true)
	primary_gun_info.text = "../%02d" % max_ammo
