extends Node2D

# Preload scenes
var level1_scene: PackedScene = preload("res://scenes/chuck_1.tscn")
var level2_scene: PackedScene = preload("res://scenes/chuck_2.tscn")
var level3_scene: PackedScene = preload("res://scenes/chuck_3.tscn")

func _switch_scene(scene: PackedScene) -> void:
	var scene_instance = scene.instantiate()
	
	# Add to root
	get_tree().root.add_child(scene_instance)
	
	# Safely remove old scene if it exists
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	# Set the new scene as current
	get_tree().current_scene = scene_instance

func _on_link_button_pressed() -> void:
	_switch_scene(level1_scene)

func _on_link_button_2_pressed() -> void:
	_switch_scene(level2_scene)

func _on_link_button_3_pressed() -> void:
	_switch_scene(level3_scene)
