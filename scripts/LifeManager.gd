extends Node

var stats: LifeStats = LifeStats.new()
var hud: LifeHUD
var auto_save: bool = true
var auto_save_timer: float = 0.0

func _ready() -> void:
	load_game()
	Engine.max_fps = 60
	create_hud()
	if hud:
		hud.refresh(stats)

func _process(delta: float) -> void:
	stats.apply_decay(delta)
	stats.time_of_day += delta * 0.75
	if stats.time_of_day >= 24.0:
		stats.time_of_day -= 24.0
		stats.day += 1
	if hud:
		hud.refresh(stats)
	if auto_save:
		auto_save_timer += delta
		if auto_save_timer >= 20.0:
			auto_save_timer = 0.0
			save_game()

func create_hud() -> void:
	hud = LifeHUD.new()
	add_child(hud)

func do_action(action_name: String) -> void:
	stats.apply_action(action_name)
	if hud:
		hud.refresh(stats)

func save_game() -> void:
	SaveSystem.save_data(stats)
	if hud and hud.status_label:
		hud.status_label.text = "Game saved."

func load_game() -> void:
	stats = SaveSystem.load_data()
