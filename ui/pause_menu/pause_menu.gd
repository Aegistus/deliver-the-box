extends Control

var paused := false

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("escape"):
		if not paused:
			pause()
		else:
			resume()

func pause():
	paused = true
	get_tree().paused = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func resume():
	paused = false
	get_tree().paused = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_main_menu_button_pressed() -> void:
	paused = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _on_exit_to_desktop_button_pressed() -> void:
	get_tree().quit()
