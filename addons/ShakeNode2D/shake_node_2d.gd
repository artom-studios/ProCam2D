@tool
extends Node2D
class_name ShakeNode2D

## A standalone shake effect node that can shake any Node2D or Control parent.
## Add this as a child to any node you want to shake, configure the shake properties,
## and call shake() to trigger the effect.

# Signals
signal shake_started
signal shake_stopped

var _rng = RandomNumberGenerator.new()

# Enums
enum ShakeType {
	VERTICAL,
	HORIZONTAL,
	RANDOM,
	PERLIN,
	ROTATE,
	CIRCULAR,
	ZOOM
}

enum Preset {
	CUSTOM,
	GUNSHOT,
	EARTHQUAKE,
	HANDHELD,
	EXPLOSION,
	IMPACT,
	RUMBLE,
	VIBRATION,
	WOBBLY
}

# Exported properties
@export_enum("Custom", "Gunshot", "Earthquake", "Handheld", "Explosion", "Impact", "Rumble", "Vibration", "Wobbly") var preset : int = Preset.CUSTOM: set = set_preset
@export_range(0, 100) var speed = 15.0
@export_range(0, 100) var intensity = 10.0
@export_flags("Vertical", "Horizontal", "Random", "Perlin", "Rotate", "Circular", "Zoom") var shake_type = 0
@export_range(0, 10) var trauma_attack = 0.0  ## Fade-in time
@export_range(0, 10) var trauma_decay = 0.8  ## Fade-out time
@export_range(0, 10) var duration = 0.5  ## Sustain time
@export var endless = false  ## If true, shake continues until stop() is called

# Private variables
var _trauma = 1.0
var _time_elapsed: float = 0.0
var _noise = FastNoiseLite.new()
var _is_shaking: bool = false
var _initial_position: Vector2 = Vector2.ZERO
var _initial_rotation: float = 0.0
var _initial_scale: Vector2 = Vector2.ONE
var _current_trauma: float = 0.0
var _parent_node: Node = null

func _ready():
	_rng.randomize()
	_noise.seed = randi()
	_noise.frequency = 0.05
	_noise.fractal_octaves = 2
	_noise.fractal_gain = 0.8
	_noise.fractal_lacunarity = 2.0
	_noise.noise_type = FastNoiseLite.TYPE_PERLIN

func _process(delta):
	if not _is_shaking:
		return
	
	# Get parent node if not already set
	if _parent_node == null:
		_parent_node = get_parent()
		if _parent_node == null:
			push_warning("ShakeNode2D: No parent node found!")
			stop()
			return
	
	# Store initial transform on first frame
	if _time_elapsed == 0:
		_store_initial_transform()
		_current_trauma = 0.0
	
	_time_elapsed += delta
	
	# Calculate trauma based on the current phase
	var total_duration = trauma_attack + duration + trauma_decay
	if _time_elapsed < trauma_attack:
		# Attack phase
		_current_trauma = min(_current_trauma + (_trauma / trauma_attack) * delta, _trauma)
	elif endless or _time_elapsed < trauma_attack + duration:
		# Sustain phase
		_current_trauma = _trauma
	elif _time_elapsed < total_duration:
		# Decay phase
		if trauma_decay > 0:
			var decay_progress = (_time_elapsed - trauma_attack - duration) / trauma_decay
			_current_trauma = max(_trauma * (1 - decay_progress), 0)
		else:
			_current_trauma = 0
	else:
		stop()
		return
	
	var shake_factor = pow(_current_trauma, 2)  # Quadratic falloff for trauma
	
	var offset := Vector2.ZERO
	var rotation_offset := 0.0
	var scale_offset := 0.0
	
	# Calculate shake offsets based on enabled shake types
	if shake_type & (1 << ShakeType.VERTICAL):
		offset.y += _calculate_offset(_time_elapsed * speed) * intensity * shake_factor
	if shake_type & (1 << ShakeType.HORIZONTAL):
		offset.x += _calculate_offset((_time_elapsed + 1000) * speed) * intensity * shake_factor
	if shake_type & (1 << ShakeType.RANDOM):
		offset += _calculate_random_offset() * shake_factor
	if shake_type & (1 << ShakeType.PERLIN):
		offset += _calculate_perlin_offset() * shake_factor
	if shake_type & (1 << ShakeType.ROTATE):
		rotation_offset = _calculate_rotation_offset() * shake_factor
	if shake_type & (1 << ShakeType.CIRCULAR):
		offset += _calculate_circular_offset() * shake_factor
	if shake_type & (1 << ShakeType.ZOOM):
		scale_offset = _calculate_zoom_offset() * shake_factor
	
	# Apply shake to parent node
	_apply_shake_to_parent(offset, rotation_offset, scale_offset)
	
	# Stop conditions
	if not endless:
		if _time_elapsed > total_duration:
			stop()

## Start or restart the shake effect
func shake():
	_is_shaking = true
	reset_shake()
	shake_started.emit()

## Check if currently shaking
func is_shaking() -> bool:
	return _is_shaking

## Reset shake timer and trauma
func reset_shake():
	_time_elapsed = 0.0
	_current_trauma = 0.0
	_parent_node = null  # Force parent re-fetch on next shake

## Stop shaking and restore parent to initial state
func stop():
	_is_shaking = false
	_restore_parent_transform()
	reset_shake()
	shake_stopped.emit()

## Add trauma to an ongoing shake (or start shaking if not already)
func add_trauma(amount: float):
	_trauma = min(_trauma + amount, 1.0)
	if not _is_shaking:
		_is_shaking = true
		_time_elapsed = 0.0

func set_preset(value):
	preset = value
	if preset != Preset.CUSTOM:
		apply_preset(preset)
	notify_property_list_changed()

func apply_preset(new_preset):
	match new_preset:
		Preset.GUNSHOT:
			_set_properties(70.0, 2.0, (1 << ShakeType.HORIZONTAL) | (1 << ShakeType.VERTICAL), 1.0, 0.05, 0.1, 0.1)
		Preset.EARTHQUAKE:
			_set_properties(15.0, 5.0, (1 << ShakeType.HORIZONTAL) | (1 << ShakeType.VERTICAL) | (1 << ShakeType.PERLIN), 0.7, 0.3, 5.0, 3.0)
		Preset.HANDHELD:
			_set_properties(1.0, 5.0, (1 << ShakeType.PERLIN) | (1 << ShakeType.ROTATE), 0.3, 0.1, 0.0, 0.0, true)
		Preset.EXPLOSION:
			_set_properties(30.0, 5.0, (1 << ShakeType.RANDOM) | (1 << ShakeType.ZOOM), 1.0, 0.1, 0.5, 0.5)
		Preset.IMPACT:
			_set_properties(80.0, 3.0, (1 << ShakeType.VERTICAL) | (1 << ShakeType.ROTATE), 1.0, 0.05, 0.2, 0.5)
		Preset.RUMBLE:
			_set_properties(10.0, 2.0, (1 << ShakeType.HORIZONTAL) | (1 << ShakeType.VERTICAL) | (1 << ShakeType.PERLIN), 0.5, 0.2, 1.0, 0.5)
		Preset.VIBRATION:
			_set_properties(100.0, 1.0, (1 << ShakeType.HORIZONTAL) | (1 << ShakeType.VERTICAL), 0.8, 0.05, 0.1, 1)
		Preset.WOBBLY:
			_set_properties(5.0, 5.0, (1 << ShakeType.ROTATE) | (1 << ShakeType.PERLIN), 0.6, 0.2, 1.5, 1.0)
	notify_property_list_changed()

func _set_properties(spd, intens, type, trm, att, dec, dur, endl = false):
	speed = spd
	intensity = intens
	shake_type = type
	_trauma = trm
	trauma_attack = att
	trauma_decay = dec
	duration = dur
	endless = endl

func _store_initial_transform():
	if _parent_node is Node2D:
		_initial_position = _parent_node.position
		_initial_rotation = _parent_node.rotation
		_initial_scale = _parent_node.scale
	elif _parent_node is Control:
		_initial_position = _parent_node.position
		_initial_rotation = _parent_node.rotation
		_initial_scale = _parent_node.scale

func _restore_parent_transform():
	if _parent_node == null:
		return
	
	if _parent_node is Node2D:
		_parent_node.position = _initial_position
		_parent_node.rotation = _initial_rotation
		_parent_node.scale = _initial_scale
	elif _parent_node is Control:
		_parent_node.position = _initial_position
		_parent_node.rotation = _initial_rotation
		_parent_node.scale = _initial_scale

func _apply_shake_to_parent(offset: Vector2, rotation_offset: float, scale_offset: float):
	if _parent_node == null:
		return
	
	if _parent_node is Node2D:
		_parent_node.position = _initial_position + offset
		_parent_node.rotation = _initial_rotation + rotation_offset
		_parent_node.scale = _initial_scale + Vector2(scale_offset, scale_offset)
	elif _parent_node is Control:
		_parent_node.position = _initial_position + offset
		_parent_node.rotation = _initial_rotation + rotation_offset
		_parent_node.scale = _initial_scale + Vector2(scale_offset, scale_offset)

# Shake calculation functions (same as PCamShake)
func _calculate_offset(t: float) -> float:
	return sin(t)

func _calculate_circular_offset() -> Vector2:
	var angle = _time_elapsed * speed
	var radius = intensity * 0.5
	return Vector2(cos(angle), sin(angle)) * radius

func _calculate_rotation_offset() -> float:
	return sin(_time_elapsed * speed) * intensity / 500.0

func _calculate_zoom_offset() -> float:
	return sin(_time_elapsed * speed * 10) * intensity / 2000  # Reduced zoom intensity

func _calculate_random_offset() -> Vector2:
	return Vector2(_rng.randf_range(-1, 1), _rng.randf_range(-1, 1)) * intensity

func _calculate_perlin_offset() -> Vector2:
	return Vector2(
		_noise.get_noise_1d(_time_elapsed * speed * 100),
		_noise.get_noise_1d((_time_elapsed + 1000) * speed * 100)
	) * intensity
