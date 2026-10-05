extends Node3D

var player: CharacterBody3D
var camera: Camera3D
var manager: LifeManager
var stats: LifeStats
var action_zones: Dictionary = {}
var current_zone: String = ""
var movement_speed: float = 5.0

func _ready() -> void:
	player = $Player
	camera = $Camera3D
	
	manager = LifeManager.new()
	add_child(manager)
	manager.setup(0)
	stats = manager.stats
	
	setup_action_zones()
	setup_camera()

func setup_action_zones() -> void:
	action_zones["Bed"] = {"zone": $Bed/ActionZone, "action": "Sleep"}
	action_zones["Desk"] = {"zone": $Desk/ActionZone, "action": "Work"}
	action_zones["Couch"] = {"zone": $Couch/ActionZone, "action": "Relax"}
	action_zones["Kitchen"] = {"zone": $Kitchen/ActionZone, "action": "Eat"}
	action_zones["Shower"] = {"zone": $Shower/ActionZone, "action": "Shower"}
	
	for zone_name in action_zones:
		var zone = action_zones[zone_name]["zone"]
		zone.area_entered.connect(func(area): _on_zone_entered(zone_name))
		zone.area_exited.connect(func(area): _on_zone_exited(zone_name))

func setup_camera() -> void:
	camera.position = player.position + Vector3(5, 8, 8)
	camera.look_at(player.position + Vector3(0, 1, 0), Vector3.UP)

func _process(delta: float) -> void:
	handle_player_movement(delta)
	update_camera(delta)
	update_hud()

func handle_player_movement(delta: float) -> void:
	var input_dir = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.z += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
		player.velocity = input_dir * movement_speed
		player.move_and_slide()
		stats.energy -= delta * 0.5

func update_camera(delta: float) -> void:
	var target_pos = player.position + Vector3(5, 8, 8)
	camera.position = camera.position.lerp(target_pos, delta * 2.0)
	camera.look_at(player.position + Vector3(0, 1, 0), Vector3.UP)

func update_hud() -> void:
	if has_node("HUD"):
		$HUD.refresh(stats)

func _on_zone_entered(zone_name: String) -> void:
	current_zone = zone_name
	if has_node("HUD") and has_node("HUD/ActionPrompt"):
		$HUD/ActionPrompt.text = "Press [E] for " + action_zones[zone_name]["action"]

func _on_zone_exited(zone_name: String) -> void:
	if current_zone == zone_name:
		current_zone = ""
		if has_node("HUD") and has_node("HUD/ActionPrompt"):
			$HUD/ActionPrompt.text = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		if current_zone != "" and current_zone in action_zones:
			var action = action_zones[current_zone]["action"]
			manager.do_action(action)
