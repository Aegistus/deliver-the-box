extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(play)

func play():
	animation_player.play("enter_exit")
