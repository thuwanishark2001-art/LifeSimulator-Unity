extends Panel
class_name StatBarUI

var fill: ColorRect
var label: Label
var value_label: Label
var stat_name: String = "Stat"

func setup(name: String) -> void:
	stat_name = name
	self.custom_minimum_size = Vector2(200, 50)
	self.modulate = Color.WHITE

	var background := ColorRect.new()
	background.color = Color(0.22, 0.22, 0.22, 1.0)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	fill = ColorRect.new()
	fill.color = Color(0.30, 0.84, 0.58, 1.0)
	fill.anchor_left = 0.02
	fill.anchor_right = 0.98
	fill.anchor_top = 0.20
	fill.anchor_bottom = 0.80
	add_child(fill)

	label = Label.new()
	label.text = stat_name
	label.add_theme_font_size_override("font_size", 14)
	label.position = Vector2(8, 6)
	add_child(label)

	value_label = Label.new()
	value_label.text = "100%"
	value_label.add_theme_font_size_override("font_size", 14)
	value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	value_label.position = Vector2(190, 6)
	add_child(value_label)

func set_value(value: float, name: String = "Stat") -> void:
	stat_name = name
	if fill:
		var ratio: float = clamp(value / 100.0, 0.0, 1.0)
		fill.anchor_left = 0.02
		fill.anchor_right = 0.02 + ratio * 0.96
		fill.anchor_top = 0.20
		fill.anchor_bottom = 0.80
		
		if value < 30.0:
			fill.color = Color(0.95, 0.3, 0.3, 1.0)
		elif value < 60.0:
			fill.color = Color(1.0, 0.8, 0.2, 1.0)
		else:
			fill.color = Color(0.30, 0.84, 0.58, 1.0)
	
	if label:
		label.text = stat_name
	if value_label:
		value_label.text = "%d%%" % int(value)
