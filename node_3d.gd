extends CharacterBody3D




func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x*0.5
		
		var camera=get_node("Camera3D")
		camera.rotation_degrees.x -= event.relative.y *0.2
		camera.rotation_degrees.x =clamp(
			camera.rotation_degrees.x, -80.0,80.0
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _physics_process(delta: float) -> void:
	const Speed =5.5
	#var input_direction_2D=Input.get_vector()
