extends RigidBody3D

func interact(player: Player):
	player.carry(self)
