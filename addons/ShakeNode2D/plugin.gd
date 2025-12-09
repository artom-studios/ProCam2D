@tool
extends EditorPlugin

const SHAKE_NODE_2D: String = "NodeShaker2D"

func _enter_tree() -> void:
	var shake_script = preload("res://addons/ShakeNode2D/shake_node_2d.gd")
	var shake_icon = preload("res://addons/ShakeNode2D/icon.svg")
	
	add_custom_type(SHAKE_NODE_2D, "Node2D", shake_script, shake_icon)

func _exit_tree() -> void:
	remove_custom_type(SHAKE_NODE_2D)
