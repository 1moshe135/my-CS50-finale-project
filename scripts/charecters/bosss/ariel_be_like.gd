extends CharacterBody2D

@export var points_from_ariel = 1500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
@export var JUMP_VELOCITY = -1000
var minime_reference =  preload("res://charecters/mobs/lil_ariel.tscn")
var note_bullet_reference = preload("res://charecters/items/music_bullet.tscn")
var alive = true
var mararah : Array
var scene_after  = "res://scenes/boss & cut scenes/klika_parking.tscn"

func _physics_process(delta):
	#for death animation
	if alive == false:
		$"Arielnimation".play("dead")
		$"Arielnimation".modulate.a = max($"Arielnimation".modulate.a - 0.01, 0.0)
		return
	
	# Apply gravity to vertical movement.
	velocity.y += gravity * delta
	
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

# shoots a music bullet
func _on_music_bullet_timer_timeout():
	#calls the shooting func
	shoot()
	
	$Arielnimation.play("talk")
	await get_tree().create_timer(0.5).timeout
	$Arielnimation.play("default")
	
	$music_bullet_timer.start()
	
# shoots a shot
func shoot():
	#shoot animation
	#$AnimatedSprite2D.play("")
	var new_note = note_bullet_reference.instantiate()
	new_note.global_position = global_position - Vector2(30, 0)
	get_parent().add_child(new_note)
	
#dies from the guitar:
func death():
	death_anima()

		
	await get_tree().create_timer(2.0).timeout
	
	var points = get_parent().get_node("DA SHAUL")
	print("Ariel lossed! +" + str(points_from_ariel) +" points!")
	points.points += points_from_ariel
	Global.points += points_from_ariel
		
	get_parent().get_node("CanvasLayer").update_points(points.points)
		
	print("Points: " + str(points))
	points.double_jump()
	

	# kill himself
	queue_free()
		
	#goes to next lvl
	get_tree().change_scene_to_file(scene_after)
	
# cool death animation: 
func death_anima():
	#$loss_sound.play()
	velocity.x = 0
	alive = false
	
	
