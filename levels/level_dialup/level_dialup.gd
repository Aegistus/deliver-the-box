extends Node3D

var min_rubberband_delay := 1.0
var max_rubberband_delay := 3.0
var movement_delay := 2.0

var min_freeze_delay := 1.0
var max_freeze_delay := 7.0

var player : Player

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(rubberband)
	player = get_tree().get_first_node_in_group("Player")

func rubberband():
	while true:
		var delay = randf_range(min_rubberband_delay, max_rubberband_delay)
		await get_tree().create_timer(delay).timeout
		var last_position = player.global_position
		await get_tree().create_timer(movement_delay).timeout
		var current_position = player.global_position
		player.global_position = last_position
		await get_tree().create_timer(.05).timeout
		player.global_position = current_position
		await get_tree().create_timer(.05).timeout
		player.global_position = last_position
		await get_tree().create_timer(.05).timeout
		player.global_position = current_position
		await get_tree().create_timer(.05).timeout
		player.global_position = last_position
