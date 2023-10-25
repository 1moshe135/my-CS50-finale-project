extends CharacterBody2D

@export var points_from_kid = 2000
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
@export var JUMP_VELOCITY = -1000
var bullet_referens =  preload("res://charecters/items/booger_bullet.tscn")

# booger_kid moving
func _physics_process(delta):
	# Apply gravity to vertical movement.
	velocity.y += gravity * delta
	move_and_slide()	

# When kid is stomped	
func _on_area_2d_body_entered(kid_collision):
	if kid_collision.is_in_group("PlayerGroup"):
		# $CollisionShape2D.disabled = true
		print("lil kid died! +" + str(points_from_kid) +" points!")
		kid_collision.points += points_from_kid
		Global.points += points_from_kid
		
		var points = kid_collision.points
		get_parent().get_node("CanvasLayer").update_points(points)
		
		print("Points: " + str(kid_collision.points))
		kid_collision.double_jump()
		queue_free()
		
# Kills player
func _on_player_dead_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		body.death()

# Shoots a shit
func _on_timer_timeout():
	#
	#  SHOOT A SHMOOCHT
	#
	shoot()
	pass

func shoot():
	$AnimatedSprite2D.play("hnana_boy")
	var new_bullet = bullet_referens.instantiate()
	new_bullet.global_position = global_position - Vector2(30, 10)
	get_parent().add_child(new_bullet)
	
	
