extends Node2D

@onready var shake_node = $Sprite2D/ShakeNode2D
@onready var ui_shake = $UIExample/Panel/ShakeNode2D

func _ready():
	# Set up button connections
	$Controls/VBoxContainer/GunshotButton.pressed.connect(_on_gunshot_pressed)
	$Controls/VBoxContainer/EarthquakeButton.pressed.connect(_on_earthquake_pressed)
	$Controls/VBoxContainer/HandheldButton.pressed.connect(_on_handheld_pressed)
	$Controls/VBoxContainer/ExplosionButton.pressed.connect(_on_explosion_pressed)
	$Controls/VBoxContainer/ImpactButton.pressed.connect(_on_impact_pressed)
	$Controls/VBoxContainer/RumbleButton.pressed.connect(_on_rumble_pressed)
	$Controls/VBoxContainer/VibrationButton.pressed.connect(_on_vibration_pressed)
	$Controls/VBoxContainer/WobblyButton.pressed.connect(_on_wobbly_pressed)
	$Controls/VBoxContainer/StopButton.pressed.connect(_on_stop_pressed)
	$Controls/VBoxContainer/UIShakeButton.pressed.connect(_on_ui_shake_pressed)

func _on_gunshot_pressed():
	shake_node.preset = ShakeNode2D.Preset.GUNSHOT
	shake_node.shake()

func _on_earthquake_pressed():
	shake_node.preset = ShakeNode2D.Preset.EARTHQUAKE
	shake_node.shake()

func _on_handheld_pressed():
	shake_node.preset = ShakeNode2D.Preset.HANDHELD
	shake_node.shake()

func _on_explosion_pressed():
	shake_node.preset = ShakeNode2D.Preset.EXPLOSION
	shake_node.shake()

func _on_impact_pressed():
	shake_node.preset = ShakeNode2D.Preset.IMPACT
	shake_node.shake()

func _on_rumble_pressed():
	shake_node.preset = ShakeNode2D.Preset.RUMBLE
	shake_node.shake()

func _on_vibration_pressed():
	shake_node.preset = ShakeNode2D.Preset.VIBRATION
	shake_node.shake()

func _on_wobbly_pressed():
	shake_node.preset = ShakeNode2D.Preset.WOBBLY
	shake_node.shake()

func _on_stop_pressed():
	shake_node.stop()
	ui_shake.stop()

func _on_ui_shake_pressed():
	ui_shake.preset = ShakeNode2D.Preset.EXPLOSION
	ui_shake.shake()
