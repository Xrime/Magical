extends Area2D

@export var speed := 500
@export var damage := 1
var direction = Vector2.ZERO
var shooter
var from_enemy := false  # ✅ belongs to player

func _ready():
	add_to_group("player_magic")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body == shooter:
		return

	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()

	elif not body.is_in_group("player"):
		queue_free()
