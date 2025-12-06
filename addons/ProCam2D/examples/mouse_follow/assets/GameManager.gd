extends Node

var score = 0
var high_score = 0
var enemies_alive = 0

@onready var score_label = $"../UI/ScoreLabel"
@onready var high_score_label = $"../UI/HighScoreLabel"
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var enemy_scene = preload("res://addons/ProCam2D/examples/mouse_follow/assets/Enemy.tscn")

const MIN_SPAWN_DISTANCE = 400.0
const MAX_SPAWN_DISTANCE = 800.0
const ARENA_SIZE = Vector2(2400, 2400)

func _ready():
	# Set custom crosshair cursor
	var crosshair_image = Image.create(32, 32, false, Image.FORMAT_RGBA8)
	crosshair_image.fill(Color(0, 0, 0, 0))

	# Draw crosshair lines
	for i in range(32):
		if i != 16:
			crosshair_image.set_pixel(16, i, Color(1, 1, 1, 0.8))
			crosshair_image.set_pixel(i, 16, Color(1, 1, 1, 0.8))

	# Draw center dot
	for x in range(14, 19):
		for y in range(14, 19):
			if (x - 16) * (x - 16) + (y - 16) * (y - 16) < 9:
				crosshair_image.set_pixel(x, y, Color(1, 1, 1, 1))

	var crosshair_texture = ImageTexture.create_from_image(crosshair_image)
	Input.set_custom_mouse_cursor(crosshair_texture, Input.CURSOR_ARROW, Vector2(16, 16))

	# Load high score
	load_high_score()
	update_ui()

	# Start enemy spawner
	enemy_spawn_timer.start()

func _on_enemy_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return

	# Limit max enemies
	if enemies_alive >= 15:
		return

	# Random position around player
	var angle = randf() * TAU
	var distance = randf_range(MIN_SPAWN_DISTANCE, MAX_SPAWN_DISTANCE)
	var spawn_pos = player.global_position + Vector2(cos(angle), sin(angle)) * distance

	# Clamp to arena bounds
	spawn_pos.x = clamp(spawn_pos.x, 100, ARENA_SIZE.x - 100)
	spawn_pos.y = clamp(spawn_pos.y, 100, ARENA_SIZE.y - 100)

	# Spawn enemy
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_pos
	enemy.tree_exited.connect(_on_enemy_died)

	enemies_alive += 1

func _on_enemy_died():
	enemies_alive -= 1
	add_score(100)

func add_score(points: int):
	score += points

	if score > high_score:
		high_score = score
		save_high_score()

	update_ui()

func update_ui():
	if score_label:
		score_label.text = "Score: %d" % score
	if high_score_label:
		high_score_label.text = "High Score: %d" % high_score

func save_high_score():
	var save_file = FileAccess.open("user://mouse_follow_highscore.save", FileAccess.WRITE)
	if save_file:
		save_file.store_32(high_score)
		save_file.close()

func load_high_score():
	if FileAccess.file_exists("user://mouse_follow_highscore.save"):
		var save_file = FileAccess.open("user://mouse_follow_highscore.save", FileAccess.READ)
		if save_file:
			high_score = save_file.get_32()
			save_file.close()
