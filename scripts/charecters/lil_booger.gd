extends CharacterBody2D

@export var points_from_kid = 1500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
@export var JUMP_VELOCITY = -1000


# booger_kid moving
func _physics_process(delta):
	# Apply gravity to vertical movement.
	velocity.y += gravity * delta
	move_and_slide()	

# When kid is stomped	
func _on_area_2d_body_entered(kid_collision):
	if kid_collision.is_in_group("PlayerGroup"):
		#$CollisionShape2D.disabled = true
		print("lil kid died! +" + str(points_from_kid) +" points!")
		kid_collision.points += points_from_kid
		Global.points += points_from_kid
		
		var points = kid_collision.points
		get_parent().get_node("CanvasLayer").update_points(points)

		print("Points: " + str(kid_collision.points))
		kid_collision.double_jump()
		$jump_sound.play()
		
		#queue_free()
		
# Kills player
func _on_player_dead_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		body.death()

#jumps like an i d i o t
func _on_Timer_timeout():
	# This function will be called when the timer times out (every 4 seconds)
	# Implement your jump logic here
	velocity.y = JUMP_VELOCITY
	# Restart the timer
	$timer.start()
