extends Area3D

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for b in bodies:
		if b.is_in_group("Player"):
			get_tree().reload_current_scene()
