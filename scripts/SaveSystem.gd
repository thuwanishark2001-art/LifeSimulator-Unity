extends RefCounted
class_name SaveSystem

const SAVE_PATH := "user://life_sim_save.cfg"
const SAVE_SLOTS: int = 3

var slot: int = 0

func _init(p_slot: int = 0) -> void:
	slot = p_slot

func save_data(stats: LifeStats) -> void:
	var config := ConfigFile.new()
	var slot_prefix := "slot_%d_" % slot
	
	config.set_value("stats", slot_prefix + "day", stats.day)
	config.set_value("stats", slot_prefix + "time_of_day", stats.time_of_day)
	config.set_value("stats", slot_prefix + "money", stats.money)
	config.set_value("stats", slot_prefix + "energy", stats.energy)
	config.set_value("stats", slot_prefix + "hunger", stats.hunger)
	config.set_value("stats", slot_prefix + "happiness", stats.happiness)
	config.set_value("stats", slot_prefix + "cleanliness", stats.cleanliness)
	config.set_value("stats", slot_prefix + "health", stats.health)
	config.set_value("stats", slot_prefix + "job_title", stats.job_title)
	config.set_value("stats", slot_prefix + "job_level", stats.job_level)
	config.set_value("stats", slot_prefix + "work_streak", stats.work_streak)
	config.set_value("stats", slot_prefix + "social_level", stats.social_level)
	config.set_value("stats", slot_prefix + "home_quality", stats.home_quality)
	config.set_value("stats", slot_prefix + "skill_level", stats.skill_level)
	config.set_value("stats", slot_prefix + "fitness_level", stats.fitness_level)
	config.set_value("stats", slot_prefix + "nutrition_score", stats.nutrition_score)
	config.set_value("stats", slot_prefix + "total_earnings", stats.total_earnings)
	config.set_value("stats", slot_prefix + "achievements", var_to_str(stats.achievements))
	
	var err := config.save(SAVE_PATH)
	if err != OK:
		push_error("Save failed: %s" % err)

func load_data() -> LifeStats:
	var stats := LifeStats.new()
	var config := ConfigFile.new()
	var slot_prefix := "slot_%d_" % slot
	
	var err := config.load(SAVE_PATH)
	if err != OK:
		return stats
	
	stats.day = int(config.get_value("stats", slot_prefix + "day", 1))
	stats.time_of_day = float(config.get_value("stats", slot_prefix + "time_of_day", 8.0))
	stats.money = float(config.get_value("stats", slot_prefix + "money", 500.0))
	stats.energy = float(config.get_value("stats", slot_prefix + "energy", 100.0))
	stats.hunger = float(config.get_value("stats", slot_prefix + "hunger", 100.0))
	stats.happiness = float(config.get_value("stats", slot_prefix + "happiness", 75.0))
	stats.cleanliness = float(config.get_value("stats", slot_prefix + "cleanliness", 80.0))
	stats.health = float(config.get_value("stats", slot_prefix + "health", 100.0))
	stats.job_title = str(config.get_value("stats", slot_prefix + "job_title", "Freelancer"))
	stats.job_level = int(config.get_value("stats", slot_prefix + "job_level", 1))
	stats.work_streak = int(config.get_value("stats", slot_prefix + "work_streak", 0))
	stats.social_level = int(config.get_value("stats", slot_prefix + "social_level", 1))
	stats.home_quality = int(config.get_value("stats", slot_prefix + "home_quality", 1))
	stats.skill_level = int(config.get_value("stats", slot_prefix + "skill_level", 1))
	stats.fitness_level = int(config.get_value("stats", slot_prefix + "fitness_level", 1))
	stats.nutrition_score = float(config.get_value("stats", slot_prefix + "nutrition_score", 50.0))
	stats.total_earnings = float(config.get_value("stats", slot_prefix + "total_earnings", 0.0))
	
	var ach_str = str(config.get_value("stats", slot_prefix + "achievements", "[]"))
	if ach_str != "[]":
		stats.achievements = str_to_var(ach_str)
	
	return stats

func get_save_info() -> Dictionary:
	var config := ConfigFile.new()
	var slot_prefix := "slot_%d_" % slot
	var err := config.load(SAVE_PATH)
	
	if err != OK:
		return {"exists": false, "day": 0, "money": 0, "job": ""}
	
	return {
		"exists": true,
		"day": int(config.get_value("stats", slot_prefix + "day", 0)),
		"money": float(config.get_value("stats", slot_prefix + "money", 0.0)),
		"job": str(config.get_value("stats", slot_prefix + "job_title", "Unknown"))
	}
