extends RefCounted
class_name SaveSystem

const SAVE_PATH := "user://life_sim_save.cfg"

static func save_data(stats: LifeStats) -> void:
	var config := ConfigFile.new()
	config.set_value("stats", "day", stats.day)
	config.set_value("stats", "time_of_day", stats.time_of_day)
	config.set_value("stats", "money", stats.money)
	config.set_value("stats", "energy", stats.energy)
	config.set_value("stats", "hunger", stats.hunger)
	config.set_value("stats", "happiness", stats.happiness)
	config.set_value("stats", "cleanliness", stats.cleanliness)
	config.set_value("stats", "health", stats.health)
	config.set_value("stats", "job_title", stats.job_title)
	config.set_value("stats", "job_level", stats.job_level)
	config.set_value("stats", "current_location", stats.current_location)
	config.set_value("stats", "work_streak", stats.work_streak)
	config.set_value("stats", "social_level", stats.social_level)
	config.set_value("stats", "home_quality", stats.home_quality)
	var err := config.save(SAVE_PATH)
	if err != OK:
		push_error("Save failed: %s" % err)

static func load_data() -> LifeStats:
	var stats := LifeStats.new()
	var config := ConfigFile.new()
	var err := config.load(SAVE_PATH)
	if err != OK:
		return stats
	stats.day = int(config.get_value("stats", "day", 1))
	stats.time_of_day = float(config.get_value("stats", "time_of_day", 8.0))
	stats.money = float(config.get_value("stats", "money", 120.0))
	stats.energy = float(config.get_value("stats", "energy", 100.0))
	stats.hunger = float(config.get_value("stats", "hunger", 100.0))
	stats.happiness = float(config.get_value("stats", "happiness", 75.0))
	stats.cleanliness = float(config.get_value("stats", "cleanliness", 80.0))
	stats.health = float(config.get_value("stats", "health", 100.0))
	stats.job_title = str(config.get_value("stats", "job_title", "Freelance Worker"))
	stats.job_level = int(config.get_value("stats", "job_level", 1))
	stats.current_location = str(config.get_value("stats", "current_location", "Apartment"))
	stats.work_streak = int(config.get_value("stats", "work_streak", 0))
	stats.social_level = int(config.get_value("stats", "social_level", 1))
	stats.home_quality = int(config.get_value("stats", "home_quality", 1))
	return stats
