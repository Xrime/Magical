extends Area2D

@export var speed := 300.0
@export var damage := 3
var direction = Vector2.ZERO
var from_enemy := true
var shooter

func _ready():
	add_to_group("enemy_magic")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body == shooter:
		return

	if from_enemy:
		# ✅ Only damage player
		if body.is_in_group("player"):
			if body.has_method("take_damage"):
				body.take_damage(damage)
			queue_free()
	else:
		# ✅ Player magic (if reused)
		if body.is_in_group("enemies"):
			if body.has_method("take_damage"):
				body.take_damage(damage)
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
