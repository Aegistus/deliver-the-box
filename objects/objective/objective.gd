extends Node3D

@onready var hitbox = %Hitbox

func _ready():
	hitbox.body_entered.connect(check_for_box)

func check_for_box(body):
	if body is TheBox:
		print("BOX COLLECTED!!!!!!!!!!!!")
