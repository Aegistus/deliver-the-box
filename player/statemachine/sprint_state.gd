extends PlayerState

var sprint := false

func enter():
	super()
	sprint = true
	footsteps()

func footsteps():
	while sprint:
		if sprint:
			%Footsteps.play()
		await get_tree().create_timer(.35).timeout

func exit():
	sprint = false

func check_transitions() -> State:
	if player.input_dir.length() <= .1 and player.is_on_floor():
		return %StandState
	if not Input.is_action_pressed("sprint"):
		return %WalkState
	if not player.is_on_floor():
		return %InAirState
	return null
