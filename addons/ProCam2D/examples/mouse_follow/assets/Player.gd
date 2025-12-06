extends CharacterBody2D

# Player movement variables
@export var speed = 200.0
@export var acceleration = 1500.0
@export var friction = 1200.0

# Shooting variables
@export var fire_rate = 0.15
@export var bullet_scene: PackedScene

var can_shoot = true
var health = 5

@onready var gun_tip = $GunTip
@onready var muzzle_flash = $MuzzleFlash

func _ready():
	# Load bullet scene if not assigned
	if bullet_scene == null:
		bullet_scene = load("res://addons/ProCam2D/examples/mouse_follow/assets/Bullet.tscn")

func _physics_process(delta):
	# Get input direction (WASD or Arrow keys)
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()

	# Apply movement with acceleration/friction
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	# Rotate to face mouse cursor
	var mouse_pos = get_global_mouse_position()
	rotation = global_position.direction_to(mouse_pos).angle()

	# Shooting
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		shoot()

	# Move the player
	move_and_slide()

func shoot():
	can_shoot = false

	# Create bullet
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = gun_tip.global_position
	bullet.setup(Vector2.RIGHT.rotated(rotation))

	# Muzzle flash
	if muzzle_flash:
		muzzle_flash.restart()
		muzzle_flash.emitting = true

	# Fire rate cooldown
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true

func take_damage(amount: int):
	health -= amount

	# Flash red
	modulate = Color(1.5, 0.5, 0.5)
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE

	if health <= 0:
		die()

func die():
	# Create death particles
	var particles = CPUParticles2D.new()
	particles.global_position = global_position
	particles.emitting = true
	particles.one_shot = true
	particles.amount = 20
	particles.lifetime = 0.8
	particles.explosiveness = 0.8
	particles.color = Color(1, 0.3, 0.4)
	particles.initial_velocity_min = 100
	particles.initial_velocity_max = 200
	get_parent().add_child(particles)

	queue_free()
