extends Node2D

# Preload the Level1 scene
var level1_scene: PackedScene = preload("res://scenes/chuck_1w.tscn")
var level2_scene: PackedScene = preload("res://scenes/chuck_2w.tscn")

func _on_link_button_pressed() -> void:
	# Instance the scene
	var scene_instance = level1_scene.instantiate()
	
	# Replace the current scene
	var root = get_tree().current_scene
	get_tree().root.add_child(scene_instance)  # Add new scene
	root.queue_free()  # Remove old scene


func _on_link_button_2_pressed() -> void:
	# Instance the scene
	var scene_instance = level2_scene.instantiate()
	
	# Replace the current scene
	var root = get_tree().current_scene
	get_tree().root.add_child(scene_instance)  # Add new scene
	root.queue_free()  # Remove old scene
