extends CharacterBody2D

@export var gravity := 900.0
@export var move_speed := 60.0
@export var health := 1
@export var shoot_rate := 2.0
@export var magic_scene: PackedScene
var player: CharacterBody2D
var shoot_timer: Timer
var is_attacking := false
var is_dead := false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_point: Node2D = $ShootPoint

func _ready():
	add_to_group("enemies")
	
	player = get_tree().get_first_node_in_group("player")

	shoot_timer = Timer.new()
	shoot_timer.wait_time = shoot_rate
	shoot_timer.autostart = true
	shoot_timer.one_shot = false
	shoot_timer.timeout.connect(shoot_magic)
	add_child(shoot_timer)

	sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta):
	if is_dead or not player:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * move_speed
	sprite.flip_h = direction.x < 0

	if not is_attacking:
		sprite.play("walk")

	move_and_slide()

func shoot_magic():
	if not magic_scene or not player:
		return
	
	is_attacking = true
	sprite.play("attack")

	var magic = magic_scene.instantiate()
	var shoot_pos = shoot_point.global_position
	magic.global_position = shoot_pos
	magic.direction = (player.global_position - shoot_pos).normalized()
	magic.from_enemy = true  # ✅ mark as enemy magic
	magic.shooter = self
	get_tree().current_scene.add_child(magic)

	await sprite.animation_finished
	is_attacking = false

func take_damage(amount := 1):
	if is_dead:
		return
	health -= amount
	if health <= 0:
		die()

func die():
	if is_dead:
		return
	is_dead = true
	shoot_timer.stop()
	velocity = Vector2.ZERO
	is_attacking = false
	sprite.play("death")
	await get_tree().create_timer(1.0).timeout
	queue_free()

func _on_animation_finished():
	if is_dead and sprite.animation == "death":
		queue_free()
