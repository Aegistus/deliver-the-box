extends CharacterBody3D

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
@onready var head = %Head
@onready var camera = %Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		var speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 8.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 8.0)
	else:
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
