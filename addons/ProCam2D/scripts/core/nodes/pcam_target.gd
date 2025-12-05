@tool
extends "pcam_base.gd"

const GROUP_NAME = "procam_targets"

## How much this target influences camera movement (0-1+ on X and Y axis)
@export var influence: Vector2 = Vector2.ONE
## How much this target's rotation influences camera rotation (0-1+)
@export var rotation_influence: float = 1.0
## Positional offset from the target's position
@export var offset: Vector2 = Vector2.ZERO
## Radius for auto-zoom calculations (visual debug circle)
@export var radius: float = 50.0: set = set_radius
## If true, camera ignores this target when it moves outside camera limits
@export var disable_outside_limits: bool = true
var velocity: Vector2 = Vector2.ZERO
var acceleration: Vector2 = Vector2.ZERO

var _prev_position: Vector2 = Vector2.ZERO

func _init() -> void:
	add_to_group(GROUP_NAME)

func _ready() -> void:
	_prev_position = global_position

func _update_velocity(delta: float) -> void:
	var current_position = global_position
	velocity = (current_position - _prev_position) / delta
	acceleration = (velocity - _prev_position) / delta
	_prev_position = current_position

func set_radius(value):
	radius = value
	queue_redraw()

func get_influence() -> Vector2:
	return Vector2(clamp(influence.x,0,1),clamp(influence.y,0,1)) if enabled else Vector2.ZERO

func get_rotation_influence() -> float:
	return rotation_influence if enabled else 0.0

func get_target_position() -> Vector2:
	return global_position + offset

func _draw_debug() -> void:
	draw_circle(Vector2.ZERO, radius, debug_color[1] - Color(0,0,0,0.7))
	draw_arc(Vector2.ZERO, radius, 0, TAU, 30, debug_color[0],2,true)
