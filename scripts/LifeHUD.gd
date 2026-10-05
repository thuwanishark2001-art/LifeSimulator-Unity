extends CanvasLayer
class_name LifeHUD

var status_label: Label
var money_label: Label
var time_label: Label
var day_label: Label
var job_label: Label
var detail_label: Label
var achievement_label: Label
var stat_bars: Dictionary = {}
var action_buttons: Dictionary = {}

func _ready() -> void:
	build_ui()

func build_ui() -> void:
	var bg := ColorRect.new()
	bg.color = Color(0.09, 0.12, 0.17, 0.9)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var title := Label.new()
	title.text = "Life Simulator"
	title.add_theme_font_size_override("font_size", 32)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.anchor_left = 0.05
	title.anchor_right = 0.95
	title.anchor_top = 0.90
	title.anchor_bottom = 0.98
	add_child(title)

	status_label = Label.new()
	status_label.text = "Balanced and productive."
	status_label.add_theme_font_size_override("font_size", 16)
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.anchor_left = 0.05
	status_label.anchor_right = 0.95
	status_label.anchor_top = 0.83
	status_label.anchor_bottom = 0.90
	add_child(status_label)

	achievement_label = Label.new()
	achievement_label.text = "Achievements: 0"
	achievement_label.add_theme_font_size_override("font_size", 12)
	achievement_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	achievement_label.anchor_left = 0.05
	achievement_label.anchor_right = 0.95
	achievement_label.anchor_top = 0.78
	achievement_label.anchor_bottom = 0.83
	add_child(achievement_label)

	detail_label = Label.new()
	detail_label.text = "Home Lv.1 | Social Lv.1 | Work Streak 0 | Fitness Lv.1"
	detail_label.add_theme_font_size_override("font_size", 11)
	detail_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	detail_label.anchor_left = 0.05
	detail_label.anchor_right = 0.95
	detail_label.anchor_top = 0.73
	detail_label.anchor_bottom = 0.78
	add_child(detail_label)

	money_label = Label.new()
	money_label.text = "$500"
	money_label.add_theme_font_size_override("font_size", 18)
	money_label.anchor_left = 0.08
	money_label.anchor_right = 0.32
	money_label.anchor_top = 0.65
	money_label.anchor_bottom = 0.72
	add_child(money_label)

	time_label = Label.new()
	time_label.text = "08:00"
	time_label.add_theme_font_size_override("font_size", 18)
	time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	time_label.anchor_left = 0.35
	time_label.anchor_right = 0.65
	time_label.anchor_top = 0.65
	time_label.anchor_bottom = 0.72
	add_child(time_label)

	day_label = Label.new()
	day_label.text = "Day 1"
	day_label.add_theme_font_size_override("font_size", 18)
	day_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	day_label.anchor_left = 0.68
	day_label.anchor_right = 0.92
	day_label.anchor_top = 0.65
	day_label.anchor_bottom = 0.72
	add_child(day_label)

	job_label = Label.new()
	job_label.text = "Freelancer - Level 1"
	job_label.add_theme_font_size_override("font_size", 14)
	job_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	job_label.anchor_left = 0.1
	job_label.anchor_right = 0.9
	job_label.anchor_top = 0.60
	job_label.anchor_bottom = 0.65
	add_child(job_label)

	stat_bars["Energy"] = create_bar("Energy", 0.08, 0.50)
	stat_bars["Hunger"] = create_bar("Hunger", 0.08, 0.40)
	stat_bars["Happiness"] = create_bar("Happiness", 0.08, 0.30)
	stat_bars["Cleanliness"] = create_bar("Cleanliness", 0.08, 0.20)
	stat_bars["Health"] = create_bar("Health", 0.08, 0.10)

	action_buttons["Work"] = create_button("Work", 0.12, 0.02, func(): get_parent().do_action("Work"))
	action_buttons["Eat"] = create_button("Eat", 0.30, 0.02, func(): get_parent().do_action("Eat"))
	action_buttons["Sleep"] = create_button("Sleep", 0.48, 0.02, func(): get_parent().do_action("Sleep"))
	action_buttons["Relax"] = create_button("Relax", 0.66, 0.02, func(): get_parent().do_action("Relax"))

func create_bar(name: String, x: float, y: float) -> StatBarUI:
	var bar := StatBarUI.new()
	bar.setup(name)
	bar.anchor_left = x
	bar.anchor_right = x + 0.80
	bar.anchor_top = y
	bar.anchor_bottom = y + 0.06
	add_child(bar)
	return bar

func create_button(text: String, x: float, y: float, callback: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.anchor_left = x - 0.08
	button.anchor_right = x + 0.08
	button.anchor_top = y - 0.03
	button.anchor_bottom = y + 0.03
	button.pressed.connect(callback)
	add_child(button)
	return button

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
		job_label.text = "%s - Level %d" % [stats.job_title, stats.job_level]
	if detail_label:
		detail_label.text = "Home Lv.%d | Social Lv.%d | Work %d | Fitness Lv.%d" % [stats.home_quality, stats.social_level, stats.work_streak, stats.fitness_level]
	if achievement_label:
		achievement_label.text = "Achievements: %d" % stats.achievements.size()

	for key in stat_bars.keys():
		var value: float = 0.0
		match key:
			"Energy": value = stats.energy
			"Hunger": value = stats.hunger
			"Happiness": value = stats.happiness
			"Cleanliness": value = stats.cleanliness
			"Health": value = stats.health
		stat_bars[key].set_value(value, key)

func get_status_text(stats: LifeStats) -> String:
	if stats.health < 25.0:
		return "CRITICAL: Health is in danger!"
	if stats.energy < 20.0:
		return "EXHAUSTED: You need rest immediately."
	if stats.hunger < 20.0:
		return "STARVING: Eat something now!"
	if stats.happiness < 20.0:
		return "DEPRESSED: Do something fun!"
	if stats.cleanliness < 20.0:
		return "FILTHY: Take a shower!"
	if stats.health < 50.0:
		return "Feeling ill. Consider resting or working out."
	if stats.happiness < 50.0:
		return "Feeling down. Try socializing or relaxing."
	if stats.energy > 80.0 and stats.happiness > 80.0:
		return "Thriving! You're in great condition!"
	return "Balanced and productive."

func format_time(time: float) -> String:
	var hour := int(time)
	var minute := int((time - hour) * 60.0)
	return "%02d:%02d" % [hour, minute]
