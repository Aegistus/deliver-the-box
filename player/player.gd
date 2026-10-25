extends CharacterBody3D
class_name Player

signal on_interact_in_range(new_interactable)
signal on_pickup_object
signal on_drop_object

@export var delay_input := false

# movement
var walk_speed := 5.0
var sprint_speed := 8.0
var air_speed := 3.0
var jump_velocity := 4.5
var mouse_sensitivity := .003

# bob variables
var bob_frequency := 2.0
var bob_amp := .08
var bob_time := 0.0

# fov variables
var base_fov := 75.0
var fov_change := 1.2

var gravity := 9.8

# interaction
var current_interactable
var currently_carrying

var input_delay_time := 1.0
var input_dir

@onready var head = %Head
@onready var camera = %Camera
@onready var interact_raycast = %InteractRaycast
@onready var carrying_point = %CarryingPoint
@onready var footsteps: AudioStreamPlayer3D = %Footsteps

var current_state := "standing"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	#if event.is_action_pressed("escape"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#if event.is_action_pressed("click"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	### INTERACTION ###
	var new_interactable = interact_raycast.get_collider()
	if new_interactable != current_interactable:
		current_interactable = new_interactable
		on_interact_in_range.emit(new_interactable)
	if Input.is_action_just_pressed("interact"):
		if delay_input:
			await get_tree().create_timer(input_delay_time).timeout
		if current_interactable:
			current_interactable.interact(self)
	if Input.is_action_just_pressed("drop"):
		if delay_input:
			await get_tree().create_timer(input_delay_time).timeout
		drop(currently_carrying)
	
	### MOVEMENT ###
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if delay_input:
			await get_tree().create_timer(input_delay_time).timeout
		velocity.y = jump_velocity
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if delay_input:
			await get_tree().create_timer(input_delay_time).timeout
		var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 8.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 8.0)
	else:
		if delay_input:
			await get_tree().create_timer(input_delay_time).timeout
		velocity.x = lerp(velocity.x, direction.x * air_speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * air_speed, delta * 2.0)
	
	# head bob
	bob_time += delta * velocity.length() * float(is_on_floor())
	camera.position = headbob(bob_time)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, sprint_speed * 2)
	var target_fov = base_fov + fov_change * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	
	move_and_slide()

func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_frequency) * bob_amp
	pos.x = cos(time * bob_frequency / 2) * bob_amp
	return pos

func carry(object):
	if object == null or currently_carrying != null:
		return
	currently_carrying = object
	carrying_point.node_b = currently_carrying.get_path()
	on_pickup_object.emit()

func drop(object):
	if currently_carrying == null:
		return
	on_drop_object.emit()
	currently_carrying.stop_interacting(self)
	carrying_point.node_b = ""
	currently_carrying = null
