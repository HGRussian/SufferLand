
extends Button

func get_drag_data(pos):
	if get_button_icon() != null:
		var cpb = Button.new()
		cpb.set_button_icon(get_button_icon())
		cpb.set_size(Vector2(40, 40))
		set_drag_preview(cpb)
		var icon = get_button_icon()
		get_parent().get_parent().icon = icon
		get_parent().get_parent().item = get_name()
		set_button_icon(null)
		get_parent().get_parent().dropping = true
		return icon


func can_drop_data(pos, data):
	return typeof(data) == TYPE_IMAGE


func drop_data(pos, data):
	get_parent().get_parent().dropping = false
	if get_button_icon() != null:
		get_parent().get_node(get_parent().get_parent().item).set_button_icon(get_button_icon())
	
	set_button_icon(data)
