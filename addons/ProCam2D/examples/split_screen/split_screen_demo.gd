extends Node2D

@onready var target1 = %Target1
@onready var target2 = %Target2

var time = 0.0

func _process(delta):
	time += delta
	
	# Move Target 1 in a circle
	target1.position.x = 200 + sin(time * 2.0) * 150
	target1.position.y = 300 + cos(time * 2.0) * 100
	
	# Move Target 2 in a figure-8
	target2.position.x = 800 + sin(time * 1.5) * 150
	target2.position.y = 300 + sin(time * 3.0) * 50
