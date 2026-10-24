extends Node3D

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(start_the_chug)

func start_the_chug():
	Engine.max_fps = 2
	Engine.time_scale = 2

func _exit_tree() -> void:
	Engine.max_fps = 60
	Engine.time_scale = 1
