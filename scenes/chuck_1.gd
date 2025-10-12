extends Area2D

var dashboard: PackedScene = preload("res://scenes/dashboard.tscn")

func _on_cancel_pressed() -> void:
	var scene_instance = dashboard.instantiate()
	
	# Add the new scene to the root
	get_tree().root.add_child(scene_instance)
	
	# Safely remove the current scene if it exists
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	# Set the new scene as the current one
	get_tree().current_scene = scene_instance
