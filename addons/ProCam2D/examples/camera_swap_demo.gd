extends Node2D

@onready var camera_1 = $ProCam2D_1
@onready var camera_2 = $ProCam2D_2
@onready var status_label = $UI/StatusLabel

func _ready():
	# Initialize: Camera 1 is active
	_on_cam_1_pressed()

func _on_cam_1_pressed():
	# Set Camera 1 priority higher than Camera 2
	camera_1.priority = 10
	camera_2.priority = 0
	status_label.text = "Active Camera: BLUE (Priority 10)"
	status_label.modulate = Color(0.4, 0.6, 1.0)

func _on_cam_2_pressed():
	# Set Camera 2 priority higher than Camera 1
	camera_1.priority = 0
	camera_2.priority = 10
	status_label.text = "Active Camera: RED (Priority 10)"
	status_label.modulate = Color(1.0, 0.4, 0.4)
