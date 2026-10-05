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
	bg.color = Color(0.09, 0.12, 0.17, 1.0)
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var title := Label.new()
	title.text = "Life Simulator"
	title.add_theme_font_size_override("font_size", 40)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.anchor_left = 0.15
	title.anchor_right = 0.85
	title.anchor_top = 0.86
	title.anchor_bottom = 0.94
	add_child(title)

	status_label = Label.new()
	status_label.text = "Balanced and productive."
	status_label.add_theme_font_size_override("font_size", 18)
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.anchor_left = 0.15
	status_label.anchor_right = 0.85
	status_label.anchor_top = 0.80
	status_label.anchor_bottom = 0.86
	add_child(status_label)

	achievement_label = Label.new()
	achievement_label.text = "Achievements: 0"
	achievement_label.add_theme_font_size_override("font_size", 14)
	achievement_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	achievement_label.anchor_left = 0.15
	achievement_label.anchor_right = 0.85
	achievement_label.anchor_top = 0.74
	achievement_label.anchor_bottom = 0.80
	add_child(achievement_label)

	detail_label = Label.new()
	detail_label.text = "Home Lv.1 | Social Lv.1 | Work Streak 0 | Fitness Lv.1"
	detail_label.add_theme_font_size_override("font_size", 13)
	detail_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	detail_label.anchor_left = 0.10
	detail_label.anchor_right = 0.90
	detail_label.anchor_top = 0.68
	detail_label.anchor_bottom = 0.74
	add_child(detail_label)

	money_label = Label.new()
	money_label.text = "$500"
	money_label.add_theme_font_size_override("font_size", 22)
	money_label.anchor_left = 0.08
	money_label.anchor_right = 0.32
	money_label.anchor_top = 0.60
	money_label.anchor_bottom = 0.66
	add_child(money_label)

	time_label = Label.new()
	time_label.text = "08:00"
	time_label.add_theme_font_size_override("font_size", 22)
	time_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	time_label.anchor_left = 0.35
	time_label.anchor_right = 0.65
	time_label.anchor_top = 0.60
	time_label.anchor_bottom = 0.66
	add_child(time_label)

	day_label = Label.new()
	day_label.text = "Day 1"
	day_label.add_theme_font_size_override("font_size", 22)
	day_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	day_label.anchor_left = 0.68
	day_label.anchor_right = 0.92
	day_label.anchor_top = 0.60
	day_label.anchor_bottom = 0.66
	add_child(day_label)

	job_label = Label.new()
	job_label.text = "Freelancer - Level 1"
	job_label.add_theme_font_size_override("font_size", 16)
	job_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	job_label.anchor_left = 0.2
	job_label.anchor_right = 0.8
	job_label.anchor_top = 0.56
	job_label.anchor_bottom = 0.60
	add_child(job_label)

	stat_bars["Energy"] = create_bar("Energy", 0.12, 0.48)
	stat_bars["Hunger"] = create_bar("Hunger", 0.12, 0.36)
	stat_bars["Happiness"] = create_bar("Happiness", 0.12, 0.24)
	stat_bars["Cleanliness"] = create_bar("Cleanliness", 0.12, 0.12)
	stat_bars["Health"] = create_bar("Health", 0.12, 0.00)

	action_buttons["Work"] = create_button("Work", 0.12, 0.19, func(): get_parent().do_action("Work"))
	action_buttons["Eat"] = create_button("Eat", 0.32, 0.19, func(): get_parent().do_action("Eat"))
	action_buttons["Sleep"] = create_button("Sleep", 0.52, 0.19, func(): get_parent().do_action("Sleep"))
	action_buttons["Relax"] = create_button("Relax", 0.72, 0.19, func(): get_parent().do_action("Relax"))
	
	action_buttons["Shower"] = create_button("Shower", 0.12, 0.08, func(): get_parent().do_action("Shower"))
	action_buttons["Socialize"] = create_button("Social", 0.32, 0.08, func(): get_parent().do_action("Socialize"))
	action_buttons["Study"] = create_button("Study", 0.52, 0.08, func(): get_parent().do_action("Study"))
	action_buttons["Workout"] = create_button("Workout", 0.72, 0.08, func(): get_parent().do_action("Workout"))
	
	action_buttons["Meditate"] = create_button("Meditate", 0.22, -0.03, func(): get_parent().do_action("Meditate"))
	action_buttons["Shop"] = create_button("Shop", 0.42, -0.03, func(): get_parent().do_action("Shop"))
	action_buttons["UpgradeHome"] = create_button("Home+", 0.62, -0.03, func(): get_parent().do_action("UpgradeHome"))
	action_buttons["Save"] = create_button("Save", 0.82, -0.03, func(): get_parent().save_game())

func create_bar(name: String, x: float, y: float) -> StatBarUI:
	var bar := StatBarUI.new()
	bar.setup(name)
	bar.anchor_left = x
	bar.anchor_right = x + 0.76
	bar.anchor_top = y
	bar.anchor_bottom = y + 0.06
	add_child(bar)
	return bar

func create_button(text: String, x: float, y: float, callback: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.anchor_left = x - 0.09
	button.anchor_right = x + 0.09
	button.anchor_top = y - 0.04
	button.anchor_bottom = y + 0.04
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
