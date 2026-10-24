extends Node3D

var console : GameConsole

var bobs: Array[String]
var delay := 2.0

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(bob)
	console = get_tree().get_first_node_in_group("GameConsole")

func bob():
	await get_tree().create_timer(2).timeout
	while true:
		if bobs.size() == 0:
			bobs.append("Bob")
		else:
			for i in bobs.size():
				bobs.append("Bob")
		console.print_to_console(array_to_string(bobs))
		await get_tree().create_timer(delay).timeout

func array_to_string(array: Array[String]) -> String:
	var string = ""
	for w in array:
		string += " " + w
	return string
