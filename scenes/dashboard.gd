extends Node2D

var scene: PackedScene = preload("res://scenes/levelh.tscn")

func _on_link_button_pressed() -> void:
	# Instance the scene
	var scene_instance = scene.instantiate()
	
	# Add new scene to root
	get_tree().root.add_child(scene_instance)
	
	# Safely remove current scene if it exists
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	# Optional: set the new scene as current
	get_tree().current_scene = scene_instance
