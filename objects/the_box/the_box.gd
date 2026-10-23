extends RigidBody3D

func interact(player: Player):
	player.carry(self)

func stop_interacting(player: Player):
	player.drop(self)
