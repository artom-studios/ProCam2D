extends CharacterBody2D

# Player movement variables
@export var speed = 200.0
@export var acceleration = 1500.0
@export var friction = 1200.0

func _physics_process(delta):
	# Get input direction (WASD or Arrow keys)
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	# Apply movement with acceleration/friction
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	# Rotate to face mouse cursor
	var mouse_pos = get_global_mouse_position()
	rotation = global_position.direction_to(mouse_pos).angle()

	# Move the player
	move_and_slide()
