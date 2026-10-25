extends Control

@onready var start: Control = %Start
@onready var level_select: Control = %LevelSelect

func _ready():
	start.visible = true
	level_select.visible = false

func _on_play_game_pressed() -> void:
	start.visible = false
	level_select.visible = true

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_1_1_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_introduction.tscn")

func _on_1_2_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_chug/level_chug.tscn")

func _on_1_3_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_dialup.tscn")

func _on_1_4_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_bad_reaction.tscn")

func _on_1_5_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_floating_point/level_floating_point.tscn")

func _on_1_6_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_goo/level_goo.tscn")

func _on_1_7_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_fork_bob/level_fork_bob.tscn")
