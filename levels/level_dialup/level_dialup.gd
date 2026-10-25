extends Node3D
class_name LevelDialup

signal on_start_freeze
signal on_stop_freeze

var min_rubberband_delay := 1.0
var max_rubberband_delay := 3.0
var movement_delay := 1.0

var min_freeze_delay := 1.0
var max_freeze_delay := 7.0

var player : Player

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(rubberband)
	player = get_tree().get_first_node_in_group("Player")

func rubberband():
	audio_stream_player_3d.play()
	while true:
		var delay = randf_range(min_rubberband_delay, max_rubberband_delay)
		await get_tree().create_timer(delay).timeout
		var last_position = player.global_position
		var next_position = player.global_position - player.basis.z
		on_start_freeze.emit()
		await get_tree().create_timer(movement_delay).timeout
		var current_position = player.global_position
		for i in 30:
			await get_tree().process_frame
			player.global_position = current_position
		await get_tree().process_frame
		player.global_position = next_position if randf() > .5 else last_position
		on_stop_freeze.emit()
