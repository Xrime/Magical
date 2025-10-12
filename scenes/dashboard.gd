extends Node2D

var scene: PackedScene = preload("res://scenes/levelh.tscn")
var scene1: PackedScene = preload("res://scenes/levelh_1.tscn")

func _on_link_button_pressed() -> void:
	var scene_instance = scene.instantiate()
	
	get_tree().root.add_child(scene_instance)
	
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	get_tree().current_scene = scene_instance



func _on_link_button_2_pressed() -> void:
	var scene_instance = scene1.instantiate()
	
	get_tree().root.add_child(scene_instance)
	
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	get_tree().current_scene = scene_instance
