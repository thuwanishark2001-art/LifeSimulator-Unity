extends CanvasLayer
class_name LifeHUD

var status_label: Label
var money_label: Label
var time_label: Label
var day_label: Label
var job_label: Label
var stat_bars: Dictionary = {}

func _ready() -> void:
	build_ui()

func build_ui() -> void:
	var bg := ColorRect.new()
	bg.color = Color(0.09, 0.12, 0.17, 1.0)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var title := Label.new()
	title.text = "Life Simulator"
	title.add_theme_font_size_override("font_size", 36)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.anchor_left = 0.2
	title.anchor_right = 0.8
	title.anchor_top = 0.88
	title.anchor_bottom = 0.96
	title.position = Vector2(0, 0)
	add_child(title)

	status_label = Label.new()
	status_label.text = "Balanced and productive."
	status_label.add_theme_font_size_override("font_size", 20)
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.anchor_left = 0.2
	status_label.anchor_right = 0.8
	status_label.anchor_top = 0.80
	status_label.anchor_bottom = 0.87
	add_child(status_label)

	money_label = Label.new()
	money_label.text = "$120"
	money_label.add_theme_font_size_override("font_size", 24)
	money_label.anchor_left = 0.05
	money_label.anchor_right = 0.30
	money_label.anchor_top = 0.72
	money_label.anchor_bottom = 0.78
	add_child(money_label)

	time_label = Label.new()
	time_label.text = "08:00"
	time_label.add_theme_font_size_override("font_size", 24)
	time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	time_label.anchor_left = 0.35
	time_label.anchor_right = 0.65
	time_label.anchor_top = 0.72
	time_label.anchor_bottom = 0.78
	add_child(time_label)

	day_label = Label.new()
	day_label.text = "Day 1"
	day_label.add_theme_font_size_override("font_size", 24)
	day_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	day_label.anchor_left = 0.70
	day_label.anchor_right = 0.95
	day_label.anchor_top = 0.72
	day_label.anchor_bottom = 0.78
	add_child(day_label)

	job_label = Label.new()
	job_label.text = "Freelance Worker"
	job_label.add_theme_font_size_override("font_size", 18)
	job_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	job_label.anchor_left = 0.2
	job_label.anchor_right = 0.8
	job_label.anchor_top = 0.66
	job_label.anchor_bottom = 0.72
	add_child(job_label)

	stat_bars["Energy"] = create_bar("Energy", 0.12, 0.50)
	stat_bars["Hunger"] = create_bar("Hunger", 0.12, 0.38)
	stat_bars["Happiness"] = create_bar("Happiness", 0.12, 0.26)
	stat_bars["Cleanliness"] = create_bar("Cleanliness", 0.12, 0.14)
	stat_bars["Health"] = create_bar("Health", 0.12, 0.02)

	create_button("Work", 0.18, 0.22, func(): get_parent().do_action("Work"))
	create_button("Eat", 0.40, 0.22, func(): get_parent().do_action("Eat"))
	create_button("Sleep", 0.62, 0.22, func(): get_parent().do_action("Sleep"))
	create_button("Relax", 0.18, 0.08, func(): get_parent().do_action("Relax"))
	create_button("Shower", 0.40, 0.08, func(): get_parent().do_action("Shower"))
	create_button("Save", 0.62, 0.08, func(): get_parent().save_game())

func create_bar(name: String, x: float, y: float) -> StatBarUI:
	var bar := StatBarUI.new()
	bar.setup(name)
	bar.anchor_left = x
	bar.anchor_right = x + 0.76
	bar.anchor_top = y
	bar.anchor_bottom = y + 0.07
	add_child(bar)
	return bar

func create_button(text: String, x: float, y: float, callback: Callable) -> void:
	var button := Button.new()
	button.text = text
	button.anchor_left = x - 0.11
	button.anchor_right = x + 0.11
	button.anchor_top = y - 0.05
	button.anchor_bottom = y + 0.05
	button.pressed.connect(callback)
	add_child(button)

func refresh(stats: LifeStats) -> void:
	if status_label:
		status_label.text = get_status_text(stats)
	if money_label:
		money_label.text = "$%d" % int(stats.money)
	if time_label:
		time_label.text = format_time(stats.time_of_day)
	if day_label:
		day_label.text = "Day %d" % stats.day
	if job_label:
		job_label.text = "%s Lv.%d" % [stats.job_title, stats.job_level]
	for key in stat_bars.keys():
		var value: float = 0.0
		match key:
			"Energy":
				value = stats.energy
			"Hunger":
				value = stats.hunger
			"Happiness":
				value = stats.happiness
			"Cleanliness":
				value = stats.cleanliness
			"Health":
				value = stats.health
		stat_bars[key].set_value(value, key)

func get_status_text(stats: LifeStats) -> String:
	if stats.health < 25.0:
		return "Health is critical. Take care of yourself."
	if stats.energy < 25.0:
		return "Very tired. Rest soon."
	if stats.hunger < 25.0:
		return "Hungry. Eat something."
	if stats.happiness < 25.0:
		return "Needs a break and a mood boost."
	if stats.cleanliness < 25.0:
		return "Dirty and uncomfortable. Shower soon."
	return "Balanced and productive."

func format_time(time: float) -> String:
	var hour := int(time)
	var minute := int((time - hour) * 60.0)
	return "%02d:%02d" % [hour, minute]
