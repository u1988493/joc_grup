class_name Player extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
var dir = 0
@export var attacking = false

func _process(delta):
	#if Input.is_action_just_pressed("atacar"):
		#attack()
	pass
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Input direction
	var direction = Input.get_axis("move_left", "move_right")
	
	dir = direction
	
	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if !attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("Idel")
			else:
				animated_sprite.play("walk")
		else:
			animated_sprite.play("jump")
	 
	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#func attack():
	#attacking = true
	#animated_sprite.play("Attack")
	#
	#if animated_sprite.flip_h == false:
		#$AttackArea/CollisionShape2D.disabled = false
	#elif animated_sprite.flip_h == true:
		#$AttackArea2/CollisionShape2D.disabled = false

	
	
#func _on_animated_sprite_2d_animation_finished():
	#if animated_sprite.animation == "Attack":
	#    $AttackArea/CollisionShape2D.disabled = true
	#    $AttackArea2/CollisionShape2D.disabled = true
	#    attacking = false
	
