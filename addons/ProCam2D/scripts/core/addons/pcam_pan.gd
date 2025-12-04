##################################################################
##################################################################
##################################################################
#############                                        #############
#############             Work in progress           #############
#############            not yet functional          #############
#############                                        #############
#############                                        #############
##################################################################
##################################################################
##################################################################


@tool
extends PCamAddon

@export var pan_speed := 1.0
@export var pan_button := 0

var _is_panning := false
var _last_mouse_position := Vector2.ZERO
var _pan_offset := Vector2.ZERO

func _init():
	stage = "process_input"

func process_input(camera, event):
	if not enabled:
		return

	if event is InputEventMouseButton and event.button_index == pan_button:
		if event.pressed:
			_start_panning(event.position)
		else:
			_stop_panning()
	elif event is InputEventMouseMotion and _is_panning:
		_update_pan(event.position)

func _start_panning(position):
	_is_panning = true
	_last_mouse_position = position

func _stop_panning():
	_is_panning = false
	_pan_offset = Vector2.ZERO

func _update_pan(position):
	var delta = position - _last_mouse_position
	_pan_offset = delta * pan_speed
	_last_mouse_position = position

func pre_process(camera, delta):
	if not enabled or _pan_offset == Vector2.ZERO:
		return

	camera._target_position -= _pan_offset
	_pan_offset = Vector2.ZERO

func reset():
	_is_panning = false
	_last_mouse_position = Vector2.ZERO
	_pan_offset = Vector2.ZERO
