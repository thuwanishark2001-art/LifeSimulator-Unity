extends Node

class_name SaveSystem

static var save_path: String = "user://life_sim_save.cfg"

static func save_data(stats: LifeStats) -> void:
	var config = ConfigFile.new()
	
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
	
	var error = config.save(save_path)
	if error != OK:
		push_error("Failed to save game: ", error)

static func load_data() -> LifeStats:
	var stats = LifeStats.new()
	var config = ConfigFile.new()
	
	var error = config.load(save_path)
	if error != OK:
		push_warning("No save file found, using defaults")
		return stats
	
	stats.day = config.get_value("stats", "day", 1)
	stats.time_of_day = config.get_value("stats", "time_of_day", 8.0)
	stats.money = config.get_value("stats", "money", 120.0)
	stats.energy = config.get_value("stats", "energy", 100.0)
	stats.hunger = config.get_value("stats", "hunger", 100.0)
	stats.happiness = config.get_value("stats", "happiness", 75.0)
	stats.cleanliness = config.get_value("stats", "cleanliness", 80.0)
	stats.health = config.get_value("stats", "health", 100.0)
	stats.job_title = config.get_value("stats", "job_title", "Freelance Worker")
	stats.job_level = config.get_value("stats", "job_level", 1)
	stats.current_location = config.get_value("stats", "current_location", "Apartment")
	
	return stats
