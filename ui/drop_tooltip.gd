extends RichTextLabel

var player : Player

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	player.on_pickup_object.connect(func(): visible = true)
	player.on_drop_object.connect(func(): visible = false)
	visible = false
	
