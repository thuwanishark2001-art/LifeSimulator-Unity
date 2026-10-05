extends Node

class_name LifeManager

var stats: LifeStats = LifeStats.new()
var hud: LifeHUD
var auto_save: bool = true
var auto_save_timer: float = 0.0

signal stats_changed
signal action_performed(action_name: String)

func _ready() -> void:
	loaded_game()
	get_tree().root.get_window().size = Vector2i(1080, 1920)

func _process(delta: float) -> void:
	stats.apply_decay(delta)
	stats.time_of_day += delta * 0.75
	
	if stats.time_of_day >= 24.0:
		stats.time_of_day -= 24.0
		stats.day += 1
	
	if hud != null:
		hud.refresh(stats)
	
	stats_changed.emit()
	
	if auto_save:
		auto_save_timer += delta
		if auto_save_timer >= 20.0:
			auto_save_timer = 0.0
			save_game()

func do_action(action: String) -> void:
	stats.apply_action(action)
	action_performed.emit(action)
	if hud != null:
		hud.refresh(stats)

func save_game() -> void:
	SaveSystem.save_data(stats)
	if hud != null and hud.status_text != null:
		hud.status_text.text = "Game saved."

func loaded_game() -> void:
	stats = SaveSystem.load_data()
	if hud != null:
		hud.refresh(stats)
