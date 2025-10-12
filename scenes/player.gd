extends CharacterBody2D

@export var magic_scene: PackedScene
var speed = 300
var is_attacking = false
var is_dead = false
var jump_force = -1000
var gravity = 4000

@onready var sprite = $AnimatedSprite2D
@onready var shoot_point = $ShootPoint if has_node("ShootPoint") else null

func _ready():
	add_to_group("player")  # ✅ used in magic collision

func handle_input():
	var direction = 0
	velocity.x = 0

	if Input.is_action_pressed("Right"):
		direction = 1
		sprite.play("run")
		sprite.flip_h = false
	elif Input.is_action_pressed("Left"):
		direction = -1
		sprite.play("run")
		sprite.flip_h = true

	velocity.x = direction * speed

	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_force
		sprite.play("jump")
	elif Input.is_action_pressed("Down") and is_on_floor():
		sprite.play("crouch")
		velocity.x = 0
	elif direction == 0 and is_on_floor() and not is_attacking:
		sprite.play("idle")

	if Input.is_action_just_pressed("shoot"):
		shoot_magic()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	handle_input()
	move_and_slide()

func shoot_magic():
	if not magic_scene:
		push_warning("❌ magic_scene not assigned in Level scene!")
		return

	var magic = magic_scene.instantiate()
	var spawn_pos = shoot_point.global_position if shoot_point else global_position
	magic.global_position = spawn_pos
	magic.direction = Vector2.LEFT if sprite.flip_h else Vector2.RIGHT
	magic.shooter = self
	magic.from_enemy = false  # ✅ make sure it’s player’s
	get_tree().current_scene.add_child(magic)

	sprite.play("attack")
	await sprite.animation_finished
	sprite.play("idle")

func take_damage(amount := 1):
	if is_dead:
		return
	die()

func die():
	if is_dead:
		return
	is_dead = true
	sprite.play("death")
	set_physics_process(false)
	await get_tree().create_timer(1.5).timeout
	respawn()

func respawn():
	is_dead = false
	set_physics_process(true)
	velocity = Vector2.ZERO
	global_position = Vector2(100, 300)
	sprite.play("idle")
