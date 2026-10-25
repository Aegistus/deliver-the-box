extends Node3D

@export var speed := 6.0

@onready var area_3d: Area3D = $Area3D

var active := false

func _ready():
	visible = false
	var obj = get_tree().get_first_node_in_group("Objective") as Objective
	obj.on_objective_completed.connect(func(): active = false)

func activate():
	visible = true
	active = true

func _physics_process(delta: float) -> void:
	if active:
		global_position -= transform.basis.z * (speed * delta)
	var bodies = area_3d.get_overlapping_bodies()
	for b in bodies:
		if b is Player:
			get_tree().reload_current_scene()
