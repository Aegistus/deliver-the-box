extends CSGCylinder3D

@export var spin_speed := 1.0

func _physics_process(delta: float) -> void:
	rotate(Vector3.UP, spin_speed * delta)
