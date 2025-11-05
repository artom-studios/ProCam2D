extends Control

func _process(_delta):
	# Only show crosshair when cursor is captured
	visible = Input.mouse_mode == Input.MOUSE_MODE_CAPTURED

	if visible:
		global_position = get_viewport().get_mouse_position() - size / 2
