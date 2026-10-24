extends Control
class_name PingDisplay

var servers = ["北京", "London", "Río de Janeiro", "Antarctica", "Toronto", "Москва"]

@onready var ping: RichTextLabel = %Ping
@onready var server: RichTextLabel = %Server

var min_ping = 50
var max_ping = 5000
var min_server_change_delay := 2.0
var max_server_change_delay := 4.0
var min_ping_change_delay := .5
var max_ping_change_delay := 2.0

func _ready():
	var door = get_tree().get_first_node_in_group("EntryDoor")
	door.on_door_open.connect(start_ping)
	door.on_door_open.connect(start_server)

func start_ping():
	while true:
		ping.text = "Ping: " + str(randi_range(min_ping, max_ping))
		var delay = randf_range(min_ping_change_delay, max_ping_change_delay)
		await get_tree().create_timer(delay).timeout

func start_server():
	while true:
		server.text = "Server: " + servers.pick_random()
		var delay = randf_range(min_server_change_delay, max_server_change_delay)
		await get_tree().create_timer(delay).timeout
