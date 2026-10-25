extends Node3D
class_name Objective

signal on_objective_completed

@onready var hitbox = %Hitbox
@onready var ribbons: GPUParticles3D = %Ribbons
@onready var confetti: GPUParticles3D = %Confetti
@onready var party_horn: AudioStreamPlayer3D = %PartyHorn
@onready var confetti_pop: AudioStreamPlayer3D = %ConfettiPop

func _ready():
	hitbox.body_entered.connect(check_for_box)

func check_for_box(body):
	if body is TheBox:
		ribbons.emitting = true
		confetti.emitting = true
		party_horn.play()
		confetti_pop.play()
		on_objective_completed.emit()
		body.queue_free()
		print("BOX COLLECTED!!!!!!!!!!!!")
