extends PlayerState

func enter():
	%Footsteps.play()

func check_transitions() -> State:
	if player.input_dir.length() > .1 and player.is_on_floor():
		if Input.is_action_pressed("sprint"):
			return %SprintState
		else:
			return %WalkState
	if not player.is_on_floor():
		return %InAirState
	return null
