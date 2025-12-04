extends Control

var time = 0.0

@onready var target1 = %Target1
@onready var target2 = %Target2
@onready var target3 = %Target3
@onready var target4 = %Target4

func _ready():
	# Share world_2d from Viewport1 to the other viewports
	$GridContainer/SubViewportContainer2/SubViewport.world_2d = $GridContainer/SubViewportContainer1/SubViewport.world_2d
	$GridContainer/SubViewportContainer3/SubViewport.world_2d = $GridContainer/SubViewportContainer1/SubViewport.world_2d
	$GridContainer/SubViewportContainer4/SubViewport.world_2d = $GridContainer/SubViewportContainer1/SubViewport.world_2d

func _process(delta):
	time += delta
	
	# Player 1 Control (WASD - Vehicle Style)
	if target1:
		var rotation_dir = 0
		var speed = 0
		
		if Input.is_key_pressed(KEY_A):
			rotation_dir -= 1
		if Input.is_key_pressed(KEY_D):
			rotation_dir += 1
		if Input.is_key_pressed(KEY_W):
			speed = 300
		if Input.is_key_pressed(KEY_S):
			speed = -150
			
		target1.rotation += rotation_dir * 3.0 * delta
		var velocity = Vector2(speed, 0).rotated(target1.rotation)
		target1.position += velocity * delta

	# Player 2 Animation (Large horizontal)
	if target2:
		target2.position.x = 500 + sin(time * 1.5) * 400
		target2.position.y = 300 + sin(time * 3.0) * 50

	# Player 3 Animation (Circular)
	if target3:
		target3.position.x = 500 + cos(time * 2.0) * 200
		target3.position.y = 300 + sin(time * 2.0) * 200

	# Player 4 Animation (Figure-8)
	if target4:
		target4.position.x = 500 + sin(time * 1.0) * 300
		target4.position.y = 300 + sin(time * 2.0) * 150
