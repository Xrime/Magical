extends Area2D   # or Node2D if that's what you used

@export var speed := 600.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta

	if position.x < -2000 or position.x > 2000:
		queue_free()
