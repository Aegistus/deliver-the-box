extends Control
class_name PingDisplay

var servers = ["北京", "London", "Río de Janeiro", "Antarctica", "Toronto", "Москва"]
var current_color := "green"

@onready var ping: RichTextLabel = %Ping
@onready var server: RichTextLabel = %Server

var run_ping := false

var min_good_ping = 15
var max_good_ping = 50
var min_bad_ping = 1000
var max_bad_ping = 5000
var min_server_change_delay := 2.0
var max_server_change_delay := 4.0
var min_ping_change_delay := .5
var max_ping_change_delay := 2.0

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(start_ping)
	door.on_door_open.connect(start_server)
	var level = get_tree().get_first_node_in_group("Level") as LevelDialup
	level.on_start_freeze.connect(bad_ping)
	level.on_stop_freeze.connect(resume_ping)
	visible = false

func start_ping():
	visible = true
	run_ping = true
	while run_ping:
		ping.text = "[color=" + current_color + "]" + "Ping: " + str(randi_range(min_good_ping, max_good_ping)) + "[/color]"
		var delay = randf_range(min_ping_change_delay, max_ping_change_delay)
		await get_tree().create_timer(delay).timeout

func start_server():
	while true:
		server.text = "[color=" + current_color + "]Server: " + servers.pick_random() + "[/color]"
		var delay = randf_range(min_server_change_delay, max_server_change_delay)
		await get_tree().create_timer(delay).timeout

func bad_ping():
	run_ping = false
	current_color = "red"
	var new_ping = str(randi_range(min_bad_ping, max_bad_ping))
	ping.text = "[color=" + current_color + "]Ping: " + new_ping + "[/color]"

func resume_ping():
	current_color = "green"
	start_ping()
	server.text = "[color=" + current_color + "]Server: " + servers.pick_random() + "[/color]"
