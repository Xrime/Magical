extends CharacterBody2D

var speed = 500
var is_attacking = false
var is_dead = false

func handle_input():
	# Reset velocity each frame
	velocity = Vector2.ZERO

	if Input.is_action_pressed("Right"):
		velocity.x = speed
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false  # Face right

	elif Input.is_action_pressed("Left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true   # Face left

	elif Input.is_action_pressed("Up"):
		$AnimatedSprite2D.play("jump")
		velocity.y=-speed
		
	elif Input.is_action_pressed("Down"):
		$AnimatedSprite2D.play("crouch")
		velocity.y =speed
	else:
		$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	handle_input()
	move_and_slide()
