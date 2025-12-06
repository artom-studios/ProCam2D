extends Node2D

var cinematic_playing = false

func _ready():
	# Hide instructions after first play
	if not $UI/SpacePrompt.visible:
		$UI/Instructions.visible = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and not cinematic_playing:
		start_cinematic()
	
	# Debug: Press R to reset
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func start_cinematic():
	cinematic_playing = true
	$UI/Instructions.visible = false
	$UI/SpacePrompt.visible = false
	$UI/PlayingLabel.visible = true
	procam.start_cinematic("intro")

func _on_cinematic_started(id):
	print("Cinematic started: ", id)

func _on_cinematic_stopped(id):
	print("Cinematic ended: ", id)
	cinematic_playing = false
	$UI/SpacePrompt.visible = true
	$UI/PlayingLabel.visible = false
