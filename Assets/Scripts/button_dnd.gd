extends Button

func get_drag_data(pos):
	if get_button_icon() != null:
		var cpb = Button.new()
		cpb.set_button_icon(get_button_icon())
		cpb.set_size(Vector2(28, 28))
		cpb.set_scale(Vector2(2,2))
		set_drag_preview(cpb)
		var icon = get_button_icon()
		set_button_icon(null)
		get_parent().get_parent().count = float(get_node("count").get_text())
		get_node("count").set_text(" ")
		get_parent().get_parent().ID = ItemsList.Item.find(get_tooltip())
		get_parent().get_parent().dropping = true
		get_parent().get_parent().tooltip = get_tooltip()
		return icon

func can_drop_data(pos, data):
	return typeof(data) == TYPE_IMAGE

func drop_data(pos, data):
	get_parent().get_parent().dropping = false
	if get_button_icon() != null:
		get_parent().get_node(get_parent().get_parent().item).set_button_icon(get_button_icon())
	set_tooltip(get_parent().get_parent().tooltip)
	get_node("count").set_text(str(get_parent().get_parent().count))
	set_button_icon(data)