extends Node3D

signal on_door_open

var open_position := Vector3(0, -1.51, 0)
var open_time := 3.0

@onready var model: CSGBox3D = %Model
@onready var door_open: AudioStreamPlayer3D = %DoorOpen

func interact(player: Player):
	var tween = get_tree().create_tween()
	tween.tween_property(model, "position", open_position, open_time)
	door_open.play()
	on_door_open.emit()

func stop_interacting(player: Player):
	pass
