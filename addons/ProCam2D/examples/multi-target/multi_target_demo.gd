extends Node2D

var time = 0.0
var current_focus_index = 0
var targets = []

func _ready():
	targets = [$Target1, $Target2, $Target3, $Target4]
	_update_radii()

func _process(delta):
	time += delta
	
	# Player 1 control (WASD)
	if targets[0]:
		var input = Vector2.ZERO
		if Input.is_key_pressed(KEY_W): input.y -= 1
		if Input.is_key_pressed(KEY_S): input.y += 1
		if Input.is_key_pressed(KEY_A): input.x -= 1
		if Input.is_key_pressed(KEY_D): input.x += 1
		targets[0].position += input.normalized() * 200 * delta
	
	# AI movements for other targets
	if targets[1]:
		targets[1].position.x = 1200 + sin(time * 1.2) * 400
		targets[1].position.y = 675 + cos(time * 1.2) * 300
	
	if targets[2]:
		targets[2].position.x = 1200 + cos(time * 0.8) * 500
		targets[2].position.y = 675 + sin(time * 1.5) * 250
	
	if targets[3]:
		targets[3].position.x = 1200 + sin(time * 1.5) * 350
		targets[3].position.y = 675 + cos(time * 0.9) * 400
	
	# TAB to switch focus (changes radius for auto-zoom)
	if Input.is_action_just_pressed("ui_focus_next"):
		_cycle_focus()

func _cycle_focus():
	current_focus_index = (current_focus_index + 1) % targets.size()
	_update_radii()

func _update_radii():
	# Larger radius for focused target = more zoom padding
	for i in range(targets.size()):
		var pcam_target = targets[i].get_node("PCamTarget")
		if i == current_focus_index:
			pcam_target.radius = 200.0  # Larger radius = camera gives more space
		else:
			pcam_target.radius = 100.0  # Normal radius
	
	$UI/PriorityLabel.text = "Focus: Player %d (TAB to switch) - Watch zoom adjust!" % (current_focus_index + 1)
