extends RichTextLabel

var player : Player

func _ready():
	visible = false
	player = get_tree().get_first_node_in_group("Player") as Player
	player.on_interact_in_range.connect(interactable_changed)

func interactable_changed(new_interactable):
	if new_interactable != null:
		visible = true
	else:
		visible = false
