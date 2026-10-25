class_name StateMachine
extends Node

@export var default_state: State
@export var target: Node

signal on_state_change(new_state : State)

var current_state: State
var previous_state: State
var process := true

func _ready():
	await get_tree().process_frame
	for child in get_children():
		child.target = target
	current_state = default_state
	if not process:
		return
	current_state.enter()

func _process(delta):
	if not process:
		return
	if current_state:
		current_state.process_state(delta)
		var next = current_state.check_transitions()
		if next != null:
			transition_to(next)

func _physics_process(delta):
	if current_state:
		current_state.process_state_physics(delta)

func _unhandled_input(event):
	if current_state:
		current_state.process_input(event)

func transition_to(next: State):
	current_state.exit()
	previous_state = current_state
	current_state = next
	current_state.enter()
	on_state_change.emit(current_state)
