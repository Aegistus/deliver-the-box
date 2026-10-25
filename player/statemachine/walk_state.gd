extends PlayerState
class_name WalkState

var walk := false

func _ready():
	pass

func enter():
	super()
	walk = true
	footsteps()

func footsteps():
	while walk:
		if walk:
			%Footsteps.play()
		await get_tree().create_timer(.55).timeout

func exit():
	walk = false

func check_transitions() -> State:
	if player.input_dir.length() <= .1 and player.is_on_floor():
		return %StandState
	if Input.is_action_pressed("sprint"):
		return %SprintState
	if not player.is_on_floor():
		return %InAirState
	return null
