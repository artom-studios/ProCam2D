extends Area2D

@export var speed = 800.0
@export var lifetime = 3.0

var velocity = Vector2.ZERO

func _ready():
	# Auto-delete after lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += velocity * delta

func setup(direction: Vector2):
	velocity = direction.normalized() * speed
	rotation = direction.angle()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
