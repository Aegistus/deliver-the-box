extends CSGBox3D

@onready var door: Node3D = $".."

func interact(player: Player):
	door.interact(player)
