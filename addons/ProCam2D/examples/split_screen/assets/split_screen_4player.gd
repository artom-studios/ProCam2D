extends Control

var time = 0.0
var game_time = 30.0
var scores = [0, 0, 0, 0]
var game_over = false

@onready var target1 = %Target1
@onready var target2 = %Target2
@onready var target3 = %Target3
@onready var target4 = %Target4

func _ready():
	# Share world_2d from Viewport1 to the other viewports
	$GridContainer/SubViewportContainer2/SubViewport.world_2d = $GridContainer/SubViewportContainer1/SubViewport.world_2d
	$GridContainer/SubViewportContainer3/SubViewport.world_2d = $GridContainer/SubViewportContainer1/SubViewport.world_2d
	$GridContainer/SubViewportContainer4/SubViewport.world_2d = $GridContainer/SubViewportContainer1/SubViewport.world_2d
	
	_spawn_coins()
	_update_ui()

func _process(delta):
	if game_over:
		return
		
	time += delta
	var remaining = max(0, game_time - time)
	
	if remaining <= 0:
		_end_game()
		return
	
	$UI/Timer.text = "Time: %d" % int(remaining)
	
	# Player 1 Control (WASD)
	if target1:
		var input = Vector2.ZERO
		if Input.is_key_pressed(KEY_W): input.y -= 1
		if Input.is_key_pressed(KEY_S): input.y += 1
		if Input.is_key_pressed(KEY_A): input.x -= 1
		if Input.is_key_pressed(KEY_D): input.x += 1
		target1.position += input.normalized() * 300 * delta

	# Player 2 Control (Arrow Keys)
	if target2:
		var input = Vector2.ZERO
		if Input.is_key_pressed(KEY_UP): input.y -= 1
		if Input.is_key_pressed(KEY_DOWN): input.y += 1
		if Input.is_key_pressed(KEY_LEFT): input.x -= 1
		if Input.is_key_pressed(KEY_RIGHT): input.x += 1
		target2.position += input.normalized() * 300 * delta

	# Player 3 Control (TFGH)
	if target3:
		var input = Vector2.ZERO
		if Input.is_key_pressed(KEY_T): input.y -= 1
		if Input.is_key_pressed(KEY_G): input.y += 1
		if Input.is_key_pressed(KEY_F): input.x -= 1
		if Input.is_key_pressed(KEY_H): input.x += 1
		target3.position += input.normalized() * 300 * delta

	# Player 4 Control (IJKL)
	if target4:
		var input = Vector2.ZERO
		if Input.is_key_pressed(KEY_I): input.y -= 1
		if Input.is_key_pressed(KEY_K): input.y += 1
		if Input.is_key_pressed(KEY_J): input.x -= 1
		if Input.is_key_pressed(KEY_L): input.x += 1
		target4.position += input.normalized() * 300 * delta

func _spawn_coins():
	var coins_container = $GridContainer/SubViewportContainer1/SubViewport/World/Coins
	for i in range(20):
		var coin = ColorRect.new()
		coin.custom_minimum_size = Vector2(20, 20)
		coin.color = Color(1, 0.9, 0.2)
		coin.position = Vector2(
			randf_range(100, 900),
			randf_range(100, 500)
		)
		coin.set_meta("collected", false)
		coins_container.add_child(coin)

func _on_coin_collected(player_index: int):
	scores[player_index] += 1
	_update_ui()

func _update_ui():
	$UI/Score1.text = "P1: %d" % scores[0]
	$UI/Score2.text = "P2: %d" % scores[1]
	$UI/Score3.text = "P3: %d" % scores[2]
	$UI/Score4.text = "P4: %d" % scores[3]

func _end_game():
	game_over = true
	var max_score = scores.max()
	var winners = []
	for i in range(4):
		if scores[i] == max_score:
			winners.append(i + 1)
	
	var winner_text = "Winner: "
	if winners.size() == 1:
		winner_text += "Player %d!" % winners[0]
	else:
		winner_text = "Tie! Players: " + str(winners)
	
	$UI/WinnerLabel.text = winner_text
	$UI/WinnerLabel.visible = true
	$UI/RestartLabel.visible = true

func check_coin_collision(player_pos: Vector2, player_index: int):
	var coins_container = $GridContainer/SubViewportContainer1/SubViewport/World/Coins
	for coin in coins_container.get_children():
		if coin.get_meta("collected"):
			continue
		var coin_rect = Rect2(coin.position, Vector2(20, 20))
		var player_rect = Rect2(player_pos - Vector2(15, 15), Vector2(30, 30))
		if coin_rect.intersects(player_rect):
			coin.queue_free()
			_on_coin_collected(player_index)
			return

func _physics_process(_delta):
	if game_over:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
		return
	
	check_coin_collision(target1.position, 0)
	check_coin_collision(target2.position, 1)
	check_coin_collision(target3.position, 2)
	check_coin_collision(target4.position, 3)
