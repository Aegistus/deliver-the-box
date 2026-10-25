extends Node3D

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(delay_input)

func delay_input():
	var player = get_tree().get_first_node_in_group("Player") as Player
	player.delay_input = true
