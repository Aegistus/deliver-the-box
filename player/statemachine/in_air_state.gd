extends PlayerState

func check_transitions() -> State:
	if player.is_on_floor():
		if player.input_dir.length() >= .1:
			if Input.is_action_pressed("sprint"):
				return %SprintState
			else:
				return %WalkState
		else:
			return %StandState
	return null
