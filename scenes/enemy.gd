extends CharacterBody2D

@export var gravity := 900.0
@export var move_speed := 60.0
@export var health := 3
@export var shoot_rate := 2.0
@export var magic_scene: PackedScene
var player: CharacterBody2D

var shoot_timer: Timer
var is_attacking := false
@onready var sprite = $AnimatedSprite2D 

func _ready():
	shoot_timer = Timer.new()
	shoot_timer.wait_time = shoot_rate
	shoot_timer.autostart = true
	shoot_timer.one_shot = false
	shoot_timer.timeout.connect(shoot_magic)
	add_child(shoot_timer)

func _physics_process(delta):
	if not player:
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * move_speed

	# Flip sprite
	sprite.flip_h = direction.x < 0

	# Only play walk if not attacking
	if not is_attacking:
		sprite.play("walk")

	move_and_slide()

func shoot_magic():
	if not magic_scene or not player:
		return
	
	is_attacking = true
	sprite.play("attack")

	# Spawn magic from hand
	var magic = magic_scene.instantiate()
	var shoot_point = $ShootPoint.global_position
	magic.global_position = shoot_point
	magic.direction = (player.global_position - shoot_point).normalized()
	get_parent().add_child(magic)

	# Wait for attack animation to finish before returning to walk
	await sprite.animation_finished
	is_attacking = false
