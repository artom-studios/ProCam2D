extends Control

func _process(_delta):
	global_position = get_global_mouse_position() - size / 2
