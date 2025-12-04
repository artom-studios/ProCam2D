extends Control

const SCENE_PATH = "res://addons/ProCam2D/examples/split_screen/split_screen_gdquest.tscn"
var loading = false

@onready var button = $CenterContainer/VBoxContainer/Button
@onready var progress_bar = $CenterContainer/VBoxContainer/ProgressBar
@onready var status_label = $CenterContainer/VBoxContainer/Label

func _ready():
	progress_bar.visible = false
	status_label.text = "Press to load Split-Screen Demo"

func _on_button_pressed():
	# Start the threaded load
	var error = ResourceLoader.load_threaded_request(SCENE_PATH)
	if error == OK:
		loading = true
		button.disabled = true
		button.text = "Loading..."
		progress_bar.visible = true
	else:
		status_label.text = "Error starting load: " + str(error)

func _process(_delta):
	if loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(SCENE_PATH, progress)
		
		if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100
		elif status == ResourceLoader.THREAD_LOAD_LOADED:
			progress_bar.value = 100
			status_label.text = "Done!"
			var scene = ResourceLoader.load_threaded_get(SCENE_PATH)
			get_tree().change_scene_to_packed(scene)
			loading = false
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			status_label.text = "Load Failed!"
			loading = false
		elif status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			status_label.text = "Invalid Resource!"
			loading = false
