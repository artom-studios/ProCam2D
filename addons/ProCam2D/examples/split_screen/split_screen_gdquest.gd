extends Control

@onready var viewport1 = $HBoxContainer/SubViewportContainer1/SubViewport
@onready var viewport2 = $HBoxContainer/SubViewportContainer2/SubViewport
@onready var target1 = %Target1
@onready var target2 = %Target2

var time = 0.0

func _ready():
	# GDQuest Method: Share World2D manually
	# This makes Viewport 2 see the same physics world as Viewport 1
	viewport2.world_2d = viewport1.world_2d
	print("SplitScreenGDQuest: Synced Viewport 2 world_2d to Viewport 1")

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

	# Player 2 Animation (Automated)
	if target2:
		target2.position.x = 800 + sin(time * 1.5) * 1500
		target2.position.y = 300 + sin(time * 3.0) * 50
