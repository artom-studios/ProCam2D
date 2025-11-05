extends Node

func _ready():
	# Capture mouse cursor
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	# Release cursor with Escape
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
