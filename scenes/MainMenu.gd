extends Control

var selected_slot: int = 0

func _ready() -> void:
	$VBox/StartButton.pressed.connect(_start_game)
	$VBox/Slot1Button.pressed.connect(func(): _start_game_for_slot(0))
	$VBox/Slot2Button.pressed.connect(func(): _start_game_for_slot(1))
	$VBox/Slot3Button.pressed.connect(func(): _start_game_for_slot(2))
	$VBox/ExitButton.pressed.connect(func(): get_tree().quit())
	_refresh_slot_labels()

func _refresh_slot_labels() -> void:
	for i in range(3):
		var save_system := SaveSystem.new(i)
		var info := save_system.get_save_info()
		var button_name := "Slot%dButton" % (i + 1)
		var button = get_node("VBox/%s" % button_name)
		if info["exists"]:
			button.text = "Slot %d - Day %d - $%d" % [i + 1, info["day"], int(info["money"])]
		else:
			button.text = "Slot %d - Empty" % [i + 1]

func _start_game() -> void:
	_start_game_for_slot(selected_slot)

func _start_game_for_slot(slot_index: int) -> void:
	selected_slot = slot_index
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")

	# Keep the selected slot available to the game scene during startup.
	var game_scene := load("res://scenes/MainGame.gd")
	if game_scene:
		pass
