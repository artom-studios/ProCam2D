extends CharacterBody2D

@export var speed = 80.0
@export var acceleration = 800.0
@export var max_chase_distance = 600.0
@export var stop_distance = 150.0

var health = 3
var player: Node2D = null
var is_chasing = false

@onready var hit_particles = $HitParticles

func _ready():
	# Find player
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if not player:
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	# Check if should chase
	if distance_to_player < max_chase_distance:
		is_chasing = true
	elif distance_to_player > max_chase_distance * 1.5:
		is_chasing = false

	# Move toward player
	if is_chasing and distance_to_player > stop_distance:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * speed, acceleration * delta)

		# Rotate to face player
		rotation = direction.angle()
	else:
		# Stop when close enough
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)

	move_and_slide()

func take_damage(amount: int):
	health -= amount

	# Hit flash
	modulate = Color(2, 2, 2)
	if hit_particles:
		hit_particles.restart()
		hit_particles.emitting = true

	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE

	if health <= 0:
		die()

func die():
	# Create death particles
	procam.get_addons()[1].shake()
	var particles = CPUParticles2D.new()
	particles.global_position = global_position
	particles.emitting = true
	particles.one_shot = true
	particles.amount = 25
	particles.lifetime = 1.0
	particles.explosiveness = 0.8
	particles.spread = 180
	particles.color = Color(0.8, 0.3, 0.9)
	particles.initial_velocity_min = 120
	particles.initial_velocity_max = 250
	particles.gravity = Vector2(0, 150)
	particles.scale_amount_min = 2.0
	particles.scale_amount_max = 5.0
	get_parent().add_child(particles)

	queue_free()

func _on_hitbox_body_entered(body):
	# Damage player on contact
	if body.has_method("take_damage"):
		body.take_damage(1)
