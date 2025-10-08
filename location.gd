extends Node3D

func _ready():
	var folder_path = "res://Assets/Medieval Village MegaKit[Standard]/Medieval Village MegaKit[Standard]/glTF/"
	var dir = DirAccess.open(folder_path)
	if dir == null:
		push_error("❌ Folder not found: " + folder_path)
		return

	var i = 0
	for file_name in dir.get_files():
		if file_name.ends_with(".glb") or file_name.ends_with(".gltf"):
			var scene_path = folder_path + file_name
			var scene = load(scene_path)
			if scene:
				var instance = scene.instantiate()
				add_child(instance)
				instance.position = Vector3(i * 5, 0, 0) # space them apart
				i += 1
				print("✅ Added to scene:", file_name)
			else:
				push_error("⚠️ Could not load: " + file_name)

	print("✅ All models loaded and placed in scene.")
