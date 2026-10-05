extends RefCounted
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
var work_streak: int = 0
var social_level: int = 1
var home_quality: int = 1

func apply_decay(delta: float) -> void:
	energy = clamp(energy - delta * 1.15, 0.0, 100.0)
	hunger = clamp(hunger - delta * 1.5, 0.0, 100.0)
	cleanliness = clamp(cleanliness - delta * 0.55, 0.0, 100.0)
	happiness = clamp(happiness - delta * 0.45, 0.0, 100.0)
	if hunger < 20.0:
		health = clamp(health - delta * 0.9, 0.0, 100.0)
	if energy < 15.0:
		happiness = clamp(happiness - delta * 0.7, 0.0, 100.0)
	if cleanliness < 15.0:
		health = clamp(health - delta * 0.4, 0.0, 100.0)

func apply_action(action_name: String) -> void:
	match action_name:
		"Work":
			money += 35.0 + job_level * 14.0
			energy -= 20.0
			hunger -= 16.0
			happiness += 2.0
			health -= 2.0
			cleanliness -= 5.0
			job_level += 1
			work_streak += 1
			if job_level > 10:
				job_title = "Senior Specialist"
			if job_level > 15:
				job_title = "Manager"
		"Eat":
			hunger += 32.0
			energy += 12.0
			health += 8.0
			money -= 7.0
			happiness += 5.0
		"Sleep":
			energy += 45.0
			hunger -= 12.0
			happiness += 10.0
			time_of_day = 7.0
			day += 1
		"Relax":
			happiness += 20.0
			energy -= 6.0
			hunger -= 7.0
		"Shower":
			cleanliness += 38.0
			happiness += 12.0
			energy -= 3.0
		"Socialize":
			happiness += 15.0
			social_level += 1
			energy -= 8.0
		"UpgradeHome":
			if money >= 50.0:
				money -= 50.0
				home_quality += 1
				happiness += 12.0
		"Study":
			health += 5.0
			happiness += 8.0
			energy -= 10.0
		_:
			pass

	energy = clamp(energy, 0.0, 100.0)
	hunger = clamp(hunger, 0.0, 100.0)
	happiness = clamp(happiness, 0.0, 100.0)
	cleanliness = clamp(cleanliness, 0.0, 100.0)
	health = clamp(health, 0.0, 100.0)
