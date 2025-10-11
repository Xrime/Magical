extends CharacterBody2D

@export var magic_scene: PackedScene
var speed = 300
var is_attacking = false
var is_dead = false
var jump_force = -700
var gravity = 4000 

func handle_input():
	var direction = 0
	velocity.x = 0 

	if Input.is_action_pressed("Right"):
		direction = 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false

	elif Input.is_action_pressed("Left"):
		direction = -1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true

	velocity.x = direction * speed

	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_force
		$AnimatedSprite2D.play("jump")

	elif Input.is_action_pressed("Down") and is_on_floor():
		$AnimatedSprite2D.play("crouch")
		velocity.x = 0

	elif direction == 0 and is_on_floor():
		$AnimatedSprite2D.play("idle")

	# Shoot magic when spacebar is pressed
	if Input.is_action_just_pressed("shoot"):
		shoot_magic()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	handle_input()
	move_and_slide()

func shoot_magic():
	if not magic_scene:
		return

	var magic = magic_scene.instantiate()

	var shoot_point = global_position
	if has_node("ShootPoint"):
		shoot_point = $ShootPoint.global_position

	magic.global_position = shoot_point

	var direction = Vector2(1, 0) if not $AnimatedSprite2D.flip_h else Vector2(-1, 0)
	magic.direction = direction   # ✅ will work once we define it in magic.gd

	get_parent().add_child(magic)
	$AnimatedSprite2D.play("attack")

func die():
	if is_dead:
		return  # Prevent multiple calls
	is_dead = true
	$AnimatedSprite2D.play("death")
	set_physics_process(false)

	await get_tree().create_timer(1.5).timeout  # wait for death animation

	respawn()
	
func respawn():
	is_dead = false
	set_physics_process(true)
	velocity = Vector2.ZERO

	# Set your desired respawn position here
	global_position = Vector2(100, 300)  # example spawn point

	$AnimatedSprite2D.play("idle")
