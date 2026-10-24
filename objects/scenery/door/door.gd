extends Node3D

var open_position := Vector3(0, -1.51, 0)
var open_time := 3.0

@onready var model: CSGBox3D = %Model

func interact(player: Player):
	var tween = get_tree().create_tween()
	tween.tween_property(model, "position", open_position, open_time)

func stop_interacting(player: Player):
	pass
