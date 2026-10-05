extends PanelContainer

class_name StatBarUI

@onready var fill_bar: ProgressBar = ProgressBar.new()
@onready var label_text: Label = Label.new()
@onready var value_text: Label = Label.new()

var stat_name: String = "Stat"

func _ready() -> void:
	modulate = Color.WHITE

func set_value(value: float, name: String) -> void:
	stat_name = name
	var clamped = clamp(value / 100.0, 0.0, 1.0)
	
	if fill_bar:
		fill_bar.value = clamped * 100.0
	
	if label_text:
		label_text.text = stat_name + ": "
	
	if value_text:
		value_text.text = str(int(value)) + "%"
