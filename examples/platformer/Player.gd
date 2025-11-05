extends KinematicBody2D

# Player movement variables
export var speed = 300.0
export var jump_velocity = -600.0
export var gravity = 1500.0
export var acceleration = 2000.0
export var friction = 2000.0

var velocity = Vector2.ZERO

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Get input direction
	var input_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# Apply horizontal movement with acceleration/friction
	if input_direction != 0:
		velocity.x = move_toward(velocity.x, input_direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Move the player
	velocity = move_and_slide(velocity, Vector2.UP)
