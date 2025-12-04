extends Node

enum FollowMode {
	SINGLE_TARGET,
	MULTI_TARGET
}

enum DragType {
	SMOOTH_DAMP,
	LOOK_AHEAD,
	AUTO_SPEED,
	SPRING_DAMP,
}

var process_frame: set = set_process_frame, get = get_process_frame
var follow_mode: int = FollowMode.SINGLE_TARGET: set = set_follow_mode, get = get_follow_mode
var drag_type : int = DragType.SMOOTH_DAMP: set = set_drag_type, get = get_drag_type
var smooth_drag: bool = true: set = set_smooth_drag, get = get_smooth_drag
var smooth_drag_speed: Vector2 = Vector2(5, 5): set = set_smooth_drag_speed, get = get_smooth_drag_speed
var prediction_time: Vector2 = Vector2(9, 9): set = set_prediction_time, get = get_prediction_time
var offset: Vector2 = Vector2.ZERO: set = set_offset, get = get_offset
var smooth_offset: bool = true: set = set_smooth_offset, get = get_smooth_offset
var smooth_offset_speed: float = 5.0: set = set_smooth_offset_speed, get = get_smooth_offset_speed
var allow_rotation: bool = false: set = set_allow_rotation, get = get_allow_rotation
var smooth_rotation: bool = true: set = set_smooth_rotation, get = get_smooth_rotation
var smooth_rotation_speed: float = 5.0: set = set_smooth_rotation_speed, get = get_smooth_rotation_speed
var zoom: float = 1.0: set = setter_for_zoom, get = get_zoom
var smooth_zoom: bool = true: set = set_smooth_zoom, get = get_smooth_zoom
var smooth_zoom_speed: float = 5.0: set = set_smooth_zoom_speed, get = get_smooth_zoom_speed
var auto_zoom: bool = true: set = set_auto_zoom, get = get_auto_zoom
var min_zoom: float = 0.0: set = set_min_zoom, get = get_min_zoom
var max_zoom: float = 1.0: set = set_max_zoom, get = get_max_zoom
var zoom_margin: float = 5.0: set = set_zoom_margin, get = get_zoom_margin
var smooth_limit: bool = true: set = set_smooth_limit, get = get_smooth_limit
var left_limit: int = -10000000: set = set_left_limit, get = get_left_limit
var right_limit: int = 10000000: set = set_right_limit, get = get_right_limit
var top_limit: int = -10000000: set = set_top_limit, get = get_top_limit
var bottom_limit: int = 10000000: set = set_bottom_limit, get = get_bottom_limit
var use_h_margins: bool = false: set = set_use_h_margins, get = get_use_h_margins
var use_v_margins: bool = false: set = set_use_v_margins, get = get_use_v_margins
var left_margin: float = 0.3: set = set_left_margin, get = get_left_margin
var right_margin: float = 0.3: set = set_right_margin, get = get_right_margin
var top_margin: float = 0.3: set = set_top_margin, get = get_top_margin
var bottom_margin: float = 0.3: set = set_bottom_margin, get = get_bottom_margin

var cameras: Array = []
var current_camera: Node2D

func _ready():
	pass

func register_camera(camera: Node2D) -> void:
	if not cameras.has(camera):
		cameras.append(camera)
		if current_camera == null:
			current_camera = camera

func unregister_camera(camera: Node2D) -> void:
	if cameras.has(camera):
		cameras.erase(camera)
		if current_camera == camera:
			if not cameras.is_empty():
				current_camera = cameras[0]
			else:
				current_camera = null

func get_camera_by_id(id: String) -> Node2D:
	for camera in cameras:
		if "camera_id" in camera and camera.camera_id == id:
			return camera
	return null

func get_cameras() -> Array:
	return cameras.duplicate()

func register_node(node: Node) -> void:
	for camera in cameras:
		if camera.has_method("register_node"):
			camera.register_node(node)

func unregister_node(node: Node) -> void:
	for camera in cameras:
		if camera.has_method("unregister_node"):
			camera.unregister_node(node)

func start_cinematic(id):
	if current_camera:
		current_camera.start_cinematic(id)

func stop_cinematic():
	if current_camera:
		current_camera.stop_cinematic()

func get_camera_bounds() -> Rect2:
	return current_camera.get_camera_bounds() if current_camera else Rect2()

func reset_camera():
	if current_camera:
		current_camera.reset_camera()
		stop_cinematic()

func add_addon(addon) -> void:
	if current_camera:
		current_camera.add_addon(addon)

func get_addons() -> Array:
	return current_camera.get_addons() if current_camera else []

func remove_addon(addon) -> void:
	if current_camera:
		current_camera.remove_addon(addon)

func set_position(new_position: Vector2):
	if current_camera:
		current_camera.set_position(new_position)

func set_rotation(new_rotation: float):
	if current_camera:
		current_camera.set_rotation(new_rotation)

func set_zoom(new_zoom: float):
	if current_camera:
		current_camera.set_zoom(new_zoom)

#setters
func set_follow_mode(value):
	follow_mode = value
	if current_camera:
		current_camera.follow_mode = value

func set_drag_type(value):
	drag_type = value
	if current_camera:
		current_camera.drag_type = value

func set_smooth_drag(value):
	smooth_drag = value
	if current_camera:
		current_camera.smooth_drag = value

func set_smooth_drag_speed(value):
	smooth_drag_speed = value
	if current_camera:
		current_camera.smooth_drag_speed = value

func set_prediction_time(value):
	prediction_time = value
	if current_camera:
		current_camera.prediction_time = value

func set_offset(value):
	offset = value
	if current_camera:
		current_camera.offset = value

func set_smooth_offset(value):
	smooth_offset = value
	if current_camera:
		current_camera.smooth_offset = value

func set_smooth_offset_speed(value):
	smooth_offset_speed = value
	if current_camera:
		current_camera.smooth_offset_speed = value

func set_allow_rotation(value):
	allow_rotation = value
	if current_camera:
		current_camera.allow_rotation = value

func set_smooth_rotation(value):
	smooth_rotation = value
	if current_camera:
		current_camera.smooth_rotation = value

func set_smooth_rotation_speed(value):
	smooth_rotation_speed = value
	if current_camera:
		current_camera.smooth_rotation_speed = value

func setter_for_zoom(value):
	zoom = value
	if current_camera:
		current_camera.zoom = value

func set_smooth_zoom(value):
	smooth_zoom = value
	if current_camera:
		current_camera.smooth_zoom = value

func set_smooth_zoom_speed(value):
	smooth_zoom_speed = value
	if current_camera:
		current_camera.smooth_zoom_speed = value

func set_auto_zoom(value):
	auto_zoom = value
	if current_camera:
		current_camera.auto_zoom = value

func set_min_zoom(value):
	min_zoom = value
	if current_camera:
		current_camera.min_zoom = value

func set_max_zoom(value):
	max_zoom = value
	if current_camera:
		current_camera.max_zoom = value

func set_zoom_margin(value):
	zoom_margin = value
	if current_camera:
		current_camera.zoom_margin = value

func set_smooth_limit(value):
	smooth_limit = value
	if current_camera:
		current_camera.smooth_limit = value

func set_left_limit(value):
	left_limit = value
	if current_camera:
		current_camera.left_limit = value

func set_right_limit(value):
	right_limit = value
	if current_camera:
		current_camera.right_limit = value

func set_top_limit(value):
	top_limit = value
	if current_camera:
		current_camera.top_limit = value

func set_bottom_limit(value):
	bottom_limit = value
	if current_camera:
		current_camera.bottom_limit = value

func set_use_h_margins(value):
	use_h_margins = value
	if current_camera:
		current_camera.use_h_margins = value

func set_use_v_margins(value):
	use_v_margins = value
	if current_camera:
		current_camera.use_v_margins = value

func set_left_margin(value):
	left_margin = value
	if current_camera:
		current_camera.left_margin = value

func set_right_margin(value):
	right_margin = value
	if current_camera:
		current_camera.right_margin = value

func set_top_margin(value):
	top_margin = value
	if current_camera:
		current_camera.top_margin = value

func set_bottom_margin(value):
	bottom_margin = value
	if current_camera:
		current_camera.bottom_margin = value

func set_process_frame(value):
	if current_camera:
		current_camera.process_frame = value

func get_follow_mode() -> int:
	return current_camera.follow_mode if current_camera else follow_mode

func get_drag_type() -> int:
	return current_camera.drag_type if current_camera else drag_type

func get_smooth_drag() -> bool:
	return current_camera.smooth_drag if current_camera else smooth_drag

func get_smooth_drag_speed() -> Vector2:
	return current_camera.smooth_drag_speed if current_camera else smooth_drag_speed

func get_prediction_time() -> Vector2:
	return current_camera.prediction_time if current_camera else prediction_time

func get_offset() -> Vector2:
	return current_camera.offset if current_camera else offset

func get_smooth_offset() -> bool:
	return current_camera.smooth_offset if current_camera else smooth_offset

func get_smooth_offset_speed() -> float:
	return current_camera.smooth_offset_speed if current_camera else smooth_offset_speed

func get_allow_rotation() -> bool:
	return current_camera.allow_rotation if current_camera else allow_rotation

func get_smooth_rotation() -> bool:
	return current_camera.smooth_rotation if current_camera else smooth_rotation

func get_smooth_rotation_speed() -> float:
	return current_camera.smooth_rotation_speed if current_camera else smooth_rotation_speed

func get_zoom() -> float:
	return current_camera.zoom if current_camera else zoom

func get_smooth_zoom() -> bool:
	return current_camera.smooth_zoom if current_camera else smooth_zoom

func get_smooth_zoom_speed() -> float:
	return current_camera.smooth_zoom_speed if current_camera else smooth_zoom_speed

func get_auto_zoom() -> bool:
	return current_camera.auto_zoom if current_camera else auto_zoom

func get_min_zoom() -> float:
	return current_camera.min_zoom if current_camera else min_zoom

func get_max_zoom() -> float:
	return current_camera.max_zoom if current_camera else max_zoom

func get_zoom_margin() -> float:
	return current_camera.zoom_margin if current_camera else zoom_margin

func get_smooth_limit() -> bool:
	return current_camera.smooth_limit if current_camera else smooth_limit

func get_left_limit() -> int:
	return current_camera.left_limit if current_camera else left_limit

func get_right_limit() -> int:
	return current_camera.right_limit if current_camera else right_limit

func get_top_limit() -> int:
	return current_camera.top_limit if current_camera else top_limit

func get_bottom_limit() -> int:
	return current_camera.bottom_limit if current_camera else bottom_limit

func get_use_h_margins() -> bool:
	return current_camera.use_h_margins if current_camera else use_h_margins

func get_use_v_margins() -> bool:
	return current_camera.use_v_margins if current_camera else use_v_margins

func get_left_margin() -> float:
	return current_camera.left_margin if current_camera else left_margin

func get_right_margin() -> float:
	return current_camera.right_margin if current_camera else right_margin

func get_top_margin() -> float:
	return current_camera.top_margin if current_camera else top_margin

func get_bottom_margin() -> float:
	return current_camera.bottom_margin if current_camera else bottom_margin

func get_process_frame() -> float:
	return current_camera.process_frame if current_camera else process_frame
