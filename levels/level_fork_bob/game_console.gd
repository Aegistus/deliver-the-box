extends Control
class_name GameConsole

const CONSOLE_MESSAGE = preload("uid://btrvrqlkwtufu")

@onready var container: VBoxContainer = %MessageContainer
@onready var scroll_container: ScrollContainer = %ScrollContainer

func print_to_console(message : String):
	var console_obj = CONSOLE_MESSAGE.instantiate() as RichTextLabel
	console_obj.text = Time.get_time_string_from_system() + ": " + message
	container.add_child(console_obj)
	scroll_container.ensure_control_visible(console_obj)
	#container.move_child(console_obj, 0)
