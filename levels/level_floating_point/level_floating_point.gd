extends Node3D

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(its_floatin_time)

func its_floatin_time():
	global_position.x = 9 * pow(10, 5)
	global_position.y = 9 * pow(10, 5)
