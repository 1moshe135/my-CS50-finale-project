extends CharacterBody2D

@export var points_from_kid = 1000
var speed = -10000  # Adjust this as needed
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Kid moving
func _physics_process(delta):
	# Check for wall collisions and change direction accordingly.
	check_wall_collisions()
	# Apply gravity to vertical movement.
	velocity.y += gravity * delta
	velocity.x = speed * delta
	
	move_and_slide()
	
	
# Kid bounces on walls
func check_wall_collisions():
	if velocity.x > 0 and $wall_check2.is_colliding():
		speed *= -1
		$Sprite2D.flip_h = false
		
	if velocity.x < 0 and $wall_check.is_colliding():
		speed *= -1
		$Sprite2D.flip_h = true
		
# When kid is stomped	
func _on_area_2d_body_entered(kid_collision):
	if kid_collision.is_in_group("PlayerGroup"):
		#$kid_dead/kid_dead_collision.disabled = true
		print("lil kid died! +" + str(points_from_kid) +" points!")
		kid_collision.points += points_from_kid
		Global.points += points_from_kid
		
		var points = kid_collision.points
		get_parent().get_node("CanvasLayer").update_points(points)
		
		print("Points: " + str(kid_collision.points))
		kid_collision.double_jump()
		
		#$CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		
		$death_sound.play()
		await get_tree().create_timer(1).timeout
		queue_free()
		
		
	if kid_collision.is_in_group("ariel"):
		queue_free()
		
		
func _on_player_dead_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		body.death()
		
