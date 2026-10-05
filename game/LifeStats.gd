extends Node

class_name LifeStats

var energy: float = 100.0
var hunger: float = 100.0
var happiness: float = 75.0
var cleanliness: float = 80.0
var health: float = 100.0
var money: float = 120.0
var day: int = 1
var time_of_day: float = 8.0
var job_title: String = "Freelance Worker"
var job_level: int = 1
var current_location: String = "Apartment"

func apply_decay(delta: float) -> void:
	energy = clamp(energy - delta * 1.1, 0.0, 100.0)
	hunger = clamp(hunger - delta * 1.4, 0.0, 100.0)
	cleanliness = clamp(cleanliness - delta * 0.5, 0.0, 100.0)
	happiness = clamp(happiness - delta * 0.4, 0.0, 100.0)
	
	if hunger < 20.0:
		health = clamp(health - delta * 0.8, 0.0, 100.0)
	
	if energy < 15.0:
		happiness = clamp(happiness - delta * 0.6, 0.0, 100.0)

func apply_action(activity: String) -> void:
	match activity:
		"Work":
			money += 30.0 + job_level * 12.0
			energy -= 18.0
			hunger -= 15.0
			happiness += 4.0
			health -= 2.0
			cleanliness -= 5.0
			job_level += 1
			if job_level > 10:
				job_title = "Senior Specialist"
			if job_level > 15:
				job_title = "Manager"
		
		"Eat":
			hunger += 30.0
			energy += 12.0
			health += 8.0
			money -= 8.0
			happiness += 5.0
		
		"Sleep":
			energy += 42.0
			hunger -= 10.0
			happiness += 8.0
			time_of_day = 7.0
			day += 1
		
		"Relax":
			happiness += 18.0
			energy -= 7.0
			hunger -= 8.0
			cleanliness -= 3.0
		
		"Shower":
			cleanliness += 35.0
			happiness += 10.0
			energy -= 3.0
		
		_:
			pass
	
	energy = clamp(energy, 0.0, 100.0)
	hunger = clamp(hunger, 0.0, 100.0)
	happiness = clamp(happiness, 0.0, 100.0)
	cleanliness = clamp(cleanliness, 0.0, 100.0)
	health = clamp(health, 0.0, 100.0)
