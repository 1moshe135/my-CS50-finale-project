extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pdf_reference = preload("res://charecters/items/pdf's.tscn")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	# looks toward the player
	var shaul = get_parent().get_node("DA SHAUL")
	if (shaul.position - position).normalized().x > 0:
		$anime_yina.flip_h = true
	else: 
		$anime_yina.flip_h = false

# Kills player
func _on_player_dead_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		body.death()

# throws a shit
func _on_timer_timeout():
	#calls the shooting func
	shoot()
	#$Arielnimation.play("talk")
	#await get_tree().create_timer(0.5).timeout
	#$Arielnimation.play("default")
	$Timer.start()
	
# shoots a shot
func shoot():
	$laser.play()
	#shoot animation
	#$AnimatedSprite2D.play("")
	var new_pdf = pdf_reference.instantiate()
	new_pdf.global_position = global_position - Vector2(0, 0)
	get_parent().add_child(new_pdf)
