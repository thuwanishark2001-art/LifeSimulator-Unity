extends Control

var slot_buttons: Array[Button] = []

func _ready() -> void:
	build_ui()

func build_ui() -> void:
	var root := VBoxContainer.new()
	root.anchor_left = 0.5
	root.anchor_top = 0.5
	root.anchor_right = 0.5
	root.anchor_bottom = 0.5
	root.offset_left = -150
	root.offset_top = -200
	root.offset_right = 150
	root.offset_bottom = 200
	root.alignment = BoxContainer.ALIGNMENT_CENTER
	root.add_theme_constant_override("separation", 16)
	add_child(root)

	var title := Label.new()
	title.text = "Apartment Scene"
	title.add_theme_font_size_override("font_size", 36)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	root.add_child(title)

	var desc := Label.new()
	desc.text = "3D World - Use arrow keys to move\nPress E near objects to interact"
	desc.add_theme_font_size_override("font_size", 14)
	desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	root.add_child(desc)

	var back := Button.new()
	back.text = "Back to Menu"
	back.pressed.connect(func(): get_tree().reload_current_scene())
	root.add_child(back)
