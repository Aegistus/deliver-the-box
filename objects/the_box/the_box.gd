extends RigidBody3D
class_name TheBox

func interact(player: Player):
	player.carry(self)
	set_collision_layer_value(3, false)

func stop_interacting(player: Player):
	set_collision_layer_value(3, true)
