extends Node2D

@onready var camera = $ProCam2D
@onready var shake_addon = PCamShake.new()

func _ready() -> void:
	# Add the shake addon dynamically
	procam.add_addon(shake_addon)

func _on_gunshot_pressed():
	shake_addon.apply_preset(shake_addon.Preset.GUNSHOT)
	shake_addon.shake()

func _on_earthquake_pressed():
	shake_addon.apply_preset(shake_addon.Preset.EARTHQUAKE)
	shake_addon.shake()

func _on_handheld_pressed():
	shake_addon.apply_preset(shake_addon.Preset.HANDHELD)
	shake_addon.shake()

func _on_explosion_pressed():
	shake_addon.apply_preset(shake_addon.Preset.EXPLOSION)
	shake_addon.shake()

func _on_impact_pressed():
	shake_addon.apply_preset(shake_addon.Preset.IMPACT)
	shake_addon.shake()

func _on_rumble_pressed():
	shake_addon.apply_preset(shake_addon.Preset.RUMBLE)
	shake_addon.shake()

func _on_vibration_pressed():
	shake_addon.apply_preset(shake_addon.Preset.VIBRATION)
	shake_addon.shake()

func _on_wobbly_pressed():
	shake_addon.apply_preset(shake_addon.Preset.WOBBLY)
	shake_addon.shake()

func _on_stop_shake_pressed():
	shake_addon.stop()
