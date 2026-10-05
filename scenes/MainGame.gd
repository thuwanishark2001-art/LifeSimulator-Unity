extends Node

var manager: LifeManager

func _ready() -> void:
	manager = LifeManager.new()
	manager.setup(0)
	add_child(manager)

	var hud := LifeHUD.new()
	manager.hud = hud
	add_child(hud)
	hud.refresh(manager.stats)

	# Minimal game loop to keep the repo runnable.
	# More scenes can be added later: apartment, city, office, gym, etc.
