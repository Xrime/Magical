extends Node2D

# Preload the chunk scenes
@onready var chunks = [
	preload("res://scenes/chuck_1.tscn"),
	preload("res://scenes/chuck_2.tscn"),
	preload("res://scenes/chuck_3.tscn")
]

# Reference to player
@onready var player = $Player

var current_chunk_index = 0
var current_chunk = null
var chunk_width = 512  # change to your real chunk width (TileMap width * tile size)

func _ready():
	load_chunk(current_chunk_index)
	player.position = Vector2(100, 100)  # start inside the chunk

func load_chunk(index):
	if current_chunk:
		current_chunk.queue_free()

	var new_chunk = chunks[index].instantiate()
	add_child(new_chunk)
	new_chunk.position = Vector2(0, 0)
	current_chunk = new_chunk
	print("Loaded chunk ", index)

func _process(_delta):
	check_chunk_switch()

func check_chunk_switch():
	var player_x = player.global_position.x
	var left_edge = 0
	var right_edge = chunk_width

	# Move right → next chunk
	if player_x > right_edge and current_chunk_index < chunks.size() - 1:
		current_chunk_index += 1
		player.global_position.x = 10  # reposition player inside next chunk
		load_chunk(current_chunk_index)

	# Move left → previous chunk
	elif player_x < left_edge and current_chunk_index > 0:
		current_chunk_index -= 1
		player.global_position.x = chunk_width - 10
		load_chunk(current_chunk_index)
