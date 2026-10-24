extends Control

var objective

func _ready():
	objective = get_tree().get_first_node_in_group("Objective")
	objective.on_objective_completed.connect(show_win_menu)
	visible = false

func show_win_menu():
	await get_tree().create_timer(3).timeout
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func go_to_next_level():
	get_tree().paused = false

func go_to_main_menu():
	get_tree().paused = false

func exit_to_desktop():
	get_tree().paused = false
	get_tree().quit()
