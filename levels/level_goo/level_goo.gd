extends Node3D

@export var viscous : Node3D

@onready var goo_light: DirectionalLight3D = $GooLight
@onready var directional_light_3d: DirectionalLight3D = $DirectionalLight3D
@onready var immadeofgoo: AudioStreamPlayer3D = $IMMADEOFGOO

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(start_the_goo)

func start_the_goo():
	viscous.activate()
	directional_light_3d.visible = false
	goo_light.visible = true
	immadeofgoo.play()
	var camera = get_tree().get_first_node_in_group("Camera") as Camera
	camera.screen_shake(.2, 10000)
