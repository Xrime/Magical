extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_height := -200.0
@export var spawn_rate := 3.0
@export var spawn_min_x := 200.0
@export var spawn_max_x := 1000.0

var timer: Timer
var player_ref: CharacterBody2D  # ✅ stores actual player reference
var player_ref1: CharacterBody2D

func _ready():
	if not enemy_scene:
		push_error("⚠️ Please assign an enemy_scene in the Inspector!")
		return

	# ✅ Find Player instance in scene
	player_ref = get_tree().get_root().find_child("Player", true, false)
	player_ref1 = get_tree().get_root().find_child("Player2", true, false)
	if not (player_ref or player_ref1):
		push_error("❌ Could not find Player node in the scene tree!")
		return

	randomize()
	timer = Timer.new()
	timer.wait_time = spawn_rate
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(spawn_enemy)
	add_child(timer)

func spawn_enemy():
	if not enemy_scene:
		return
	
	var enemy = enemy_scene.instantiate()
	var random_x = randf_range(spawn_min_x, spawn_max_x)
	enemy.position = Vector2(random_x, spawn_height)
	
	if player_ref:
		enemy.player = player_ref
	elif player_ref1:
		enemy.player = player_ref1

	
	get_parent().add_child(enemy)
	print("👾 Spawned enemy at:", enemy.position)
