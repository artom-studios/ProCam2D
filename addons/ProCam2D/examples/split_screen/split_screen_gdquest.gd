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
	
	# Animate targets (same as other demo)
	if target1:
		target1.position.x = 200 + sin(time * 2.0) * 150
		target1.position.y = 300 + cos(time * 2.0) * 100
	
	if target2:
		target2.position.x = 800 + sin(time * 1.5) * 150
		target2.position.y = 300 + sin(time * 3.0) * 50
