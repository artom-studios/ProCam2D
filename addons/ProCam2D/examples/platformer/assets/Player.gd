extends CharacterBody2D

# Player movement variables
@export var speed = 300.0
@export var jump_velocity = -600.0
@export var gravity = 1500.0
@export var acceleration = 2000.0
@export var friction = 2000.0

@export var look_ahead_distance = 200.0
var land_shake
var hand_shake

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Get input direction
	var input_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	# Apply horizontal movement with acceleration/friction
	if input_direction != 0:
		velocity.x = move_toward(velocity.x, input_direction * speed, acceleration * delta)
		# Look ahead in the direction of movement
		procam.offset = Vector2(look_ahead_distance * sign(input_direction), 0)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var was_on_floor = is_on_floor()
	# Move the player
	move_and_slide()
	
	if not was_on_floor and is_on_floor():
		land_shake.shake()
		
func _ready():
	land_shake = procam.get_addons()[0]
