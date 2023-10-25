extends CharacterBody2D

@export var points_from_umi = 1500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
@export var JUMP_VELOCITY = -200
var minime_reference =  preload("res://charecters/mobs/lil_danic.tscn")
var alive = true
var counter = 0 # amount of hits hit
var lives = 10 # max amount of hits can be taken


func _physics_process(delta):
	#for death animation
	if alive == false:
		$"Arielnimation".play("dead")
		$"Arielnimation".modulate.a = max($"Arielnimation".modulate.a - 0.01, 0.0)
		return
	
	# Apply gravity to vertical movement.
	velocity.y += gravity * delta
	
	#counts hits
	if counter == lives:
		death()
	
	var shaul = get_parent().get_node("DA SHAUL")
	if (shaul.position - position).normalized().x > 0:
		$Arielnimation.flip_h = true
	else: 
		$Arielnimation.flip_h = false
	
	move_and_slide()	

# Kills player
func _on_player_dead_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		body.death()

# jumps like an i d i o t
func _on_timer_timeout():
	# This function will be called when the timer times out (every 4 seconds)
	# Implement your jump logic here
	velocity.y = JUMP_VELOCITY
	# Restart the timeres
	$Timer.start()

# calls the birth func
func _on_summon_timeout():
	give_birth()
	$summon.start()

# give birth to minime's
func give_birth():
	#$AnimatedSprite2D.play("")
	var minime = minime_reference.instantiate()
	minime.global_position = global_position - Vector2(60, 0)
	get_parent().add_child(minime)
	
# death
func death():
	death_anima()
	
	await get_tree().create_timer(2.0).timeout
	
	var points = get_parent().get_node("DA SHAUL")
	print("UMI lossed! +" + str(points_from_umi) +" points!")
	points.points += points_from_umi
	get_parent().get_node("CanvasLayer").update_points(points.points)
	print("Points: " + str(points))
	points.double_jump()
	
	# kill himself
	queue_free()
	# moves to end scene
	get_tree().change_scene_to_file("res://scenes/other/kupon_landver.tscn")
	
# cool death animation: 
func death_anima():
	#$loss_sound.play()
	velocity.x = 0
	alive = false
	
# count hits
func _on_umi_dead_body_entered(player):
	if player.is_in_group("PlayerGroup"):
		player.double_jump()
		#player.$"player collision".disabled = true
		
		counter += 1
		print(str(counter) + " <- count | lives-> " + str(lives))
		
		get_parent().get_node("boss_hp").update_lives(lives - counter)
	
		print("umi was hit! +" + str(points_from_umi) +" points!")
		player.points += points_from_umi
		var points = player.points
		get_parent().get_node("CanvasLayer").update_points(points)
		print("Points: " + str(player.points))
		
		Global.points += points_from_umi

