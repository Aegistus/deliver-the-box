extends Node3D

signal on_objective_completed

@onready var hitbox = %Hitbox
@onready var ribbons: GPUParticles3D = %Ribbons
@onready var confetti: GPUParticles3D = %Confetti

func _ready():
	hitbox.body_entered.connect(check_for_box)

func check_for_box(body):
	if body is TheBox:
		ribbons.emitting = true
		confetti.emitting = true
		on_objective_completed.emit()
		print("BOX COLLECTED!!!!!!!!!!!!")
