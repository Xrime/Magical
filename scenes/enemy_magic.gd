extends Area2D

@export var speed := 400.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta

	# Remove if too far away
	if position.x < -2000 or position.x > 4000:
		queue_free()

func _on_body_entered(body):
	
	if body.is_in_group("player"):  
		if body.has_method("die"):
			body.die()  # Call the player's death function
		queue_free()  # remove the magic
