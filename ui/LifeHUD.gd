extends Control

class_name LifeHUD

@onready var status_text: Label = Label.new()
@onready var money_text: Label = Label.new()
@onready var time_text: Label = Label.new()
@onready var day_text: Label = Label.new()
@onready var job_text: Label = Label.new()

var energy_bar: StatBarUI
var hunger_bar: StatBarUI
var happiness_bar: StatBarUI
var cleanliness_bar: StatBarUI
var health_bar: StatBarUI

func _ready() -> void:
	anchor_left = 0.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0

func refresh(stats: LifeStats) -> void:
	if status_text:
		status_text.text = get_status_text(stats)
	
	if money_text:
		money_text.text = "$" + str(int(stats.money))
	
	if time_text:
		time_text.text = format_time(stats.time_of_day)
	
	if day_text:
		day_text.text = "Day " + str(stats.day)
	
	if job_text:
		job_text.text = stats.job_title + " Lv." + str(stats.job_level)
	
	if energy_bar:
		energy_bar.set_value(stats.energy, "Energy")
	if hunger_bar:
		hunger_bar.set_value(stats.hunger, "Hunger")
	if happiness_bar:
		happiness_bar.set_value(stats.happiness, "Happiness")
	if cleanliness_bar:
		cleanliness_bar.set_value(stats.cleanliness, "Cleanliness")
	if health_bar:
		health_bar.set_value(stats.health, "Health")

func get_status_text(stats: LifeStats) -> String:
	if stats.health < 25.0:
		return "Health is critical. Take care of yourself."
	if stats.energy < 25.0:
		return "Very tired. Rest soon."
	if stats.hunger < 25.0:
		return "Hungry. Eat something."
	if stats.happiness < 25.0:
		return "Needs a break and a mood boost."
	if stats.cleanliness < 25.0:
		return "Dirty and uncomfortable. Shower soon."
	return "Balanced and productive."

func format_time(time: float) -> String:
	var hour = int(time)
	var minute = int((time - hour) * 60.0)
	return "%02d:%02d" % [hour, minute]
