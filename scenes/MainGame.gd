extends Node

func _ready() -> void:
	var manager = LifeManager.new()
	add_child(manager)
	
	var hud = LifeHUD.new()
	add_child(hud)
	manager.hud = hud
	
	setup_ui(manager, hud)
	
	manager.loaded_game()
	hud.refresh(manager.stats)

func setup_ui(manager: LifeManager, hud: LifeHUD) -> void:
	# Main panel background
	var panel = PanelContainer.new()
	panel.anchor_left = 0.0
	panel.anchor_top = 0.0
	panel.anchor_right = 1.0
	panel.anchor_bottom = 1.0
	hud.add_child(panel)
	
	# Title
	var title = Label.new()
	title.text = "Life Simulator"
	title.add_theme_font_size_override("font_size", 36)
	title.alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.anchor_left = 0.2
	title.anchor_top = 0.88
	title.anchor_right = 0.8
	title.anchor_bottom = 0.95
	hud.add_child(title)
	
	# Status
	hud.status_text = Label.new()
	hud.status_text.text = "Balanced and productive."
	hud.status_text.add_theme_font_size_override("font_size", 20)
	hud.status_text.alignment = HORIZONTAL_ALIGNMENT_CENTER
	hud.status_text.anchor_left = 0.2
	hud.status_text.anchor_top = 0.80
	hud.status_text.anchor_right = 0.8
	hud.status_text.anchor_bottom = 0.87
	hud.add_child(hud.status_text)
	
	# Top HUD: Money, Time, Day
	hud.money_text = Label.new()
	hud.money_text.text = "$120"
	hud.money_text.add_theme_font_size_override("font_size", 24)
	hud.money_text.alignment = HORIZONTAL_ALIGNMENT_LEFT
	hud.money_text.anchor_left = 0.05
	hud.money_text.anchor_top = 0.72
	hud.money_text.anchor_right = 0.3
	hud.money_text.anchor_bottom = 0.78
	hud.add_child(hud.money_text)
	
	hud.time_text = Label.new()
	hud.time_text.text = "08:00"
	hud.time_text.add_theme_font_size_override("font_size", 24)
	hud.time_text.alignment = HORIZONTAL_ALIGNMENT_CENTER
	hud.time_text.anchor_left = 0.35
	hud.time_text.anchor_top = 0.72
	hud.time_text.anchor_right = 0.65
	hud.time_text.anchor_bottom = 0.78
	hud.add_child(hud.time_text)
	
	hud.day_text = Label.new()
	hud.day_text.text = "Day 1"
	hud.day_text.add_theme_font_size_override("font_size", 24)
	hud.day_text.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	hud.day_text.anchor_left = 0.7
	hud.day_text.anchor_top = 0.72
	hud.day_text.anchor_right = 0.95
	hud.day_text.anchor_bottom = 0.78
	hud.add_child(hud.day_text)
	
	# Job info
	hud.job_text = Label.new()
	hud.job_text.text = "Freelance Worker"
	hud.job_text.add_theme_font_size_override("font_size", 18)
	hud.job_text.alignment = HORIZONTAL_ALIGNMENT_CENTER
	hud.job_text.anchor_left = 0.2
	hud.job_text.anchor_top = 0.65
	hud.job_text.anchor_right = 0.8
	hud.job_text.anchor_bottom = 0.71
	hud.add_child(hud.job_text)
	
	# Stat bars
	hud.energy_bar = create_stat_bar(hud, "Energy", 0.12, 0.50)
	hud.hunger_bar = create_stat_bar(hud, "Hunger", 0.12, 0.38)
	hud.happiness_bar = create_stat_bar(hud, "Happiness", 0.12, 0.26)
	hud.cleanliness_bar = create_stat_bar(hud, "Cleanliness", 0.12, 0.14)
	hud.health_bar = create_stat_bar(hud, "Health", 0.12, 0.02)
	
	# Action buttons
	create_button(hud, manager, "Work", 0.18, 0.22)
	create_button(hud, manager, "Eat", 0.40, 0.22)
	create_button(hud, manager, "Sleep", 0.62, 0.22)
	create_button(hud, manager, "Relax", 0.18, 0.08)
	create_button(hud, manager, "Shower", 0.40, 0.08)
	create_button(hud, manager, "Save", 0.62, 0.08)

func create_stat_bar(hud: LifeHUD, name: String, x: float, y: float) -> StatBarUI:
	var bar = StatBarUI.new()
	
	var bg = PanelContainer.new()
	bg.anchor_left = x
	bg.anchor_top = y
	bg.anchor_right = x + 0.76
	bg.anchor_bottom = y + 0.07
	hud.add_child(bg)
	
	var progress = ProgressBar.new()
	progress.min_value = 0.0
	progress.max_value = 100.0
	progress.value = 100.0
	progress.anchor_left = 0.05
	progress.anchor_top = 0.2
	progress.anchor_right = 0.95
	progress.anchor_bottom = 0.8
	bg.add_child(progress)
	bar.fill_bar = progress
	
	var label = Label.new()
	label.text = name + ": "
	label.add_theme_font_size_override("font_size", 14)
	label.anchor_left = 0.02
	label.anchor_top = 0.1
	label.anchor_right = 0.48
	label.anchor_bottom = 0.9
	bg.add_child(label)
	bar.label_text = label
	
	var value = Label.new()
	value.text = "100%"
	value.add_theme_font_size_override("font_size", 14)
	value.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	value.anchor_left = 0.68
	value.anchor_top = 0.1
	value.anchor_right = 0.98
	value.anchor_bottom = 0.9
	bg.add_child(value)
	bar.value_text = value
	bar.stat_name = name
	
	return bar

func create_button(hud: LifeHUD, manager: LifeManager, text: String, x: float, y: float) -> void:
	var btn = Button.new()
	btn.text = text
	btn.anchor_left = x - 0.11
	btn.anchor_top = y - 0.05
	btn.anchor_right = x + 0.11
	btn.anchor_bottom = y + 0.05
	hud.add_child(btn)
	
	btn.pressed.connect(func(): manager.do_action(text))
