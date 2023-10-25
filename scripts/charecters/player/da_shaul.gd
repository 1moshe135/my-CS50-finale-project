extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var points = 0
@export var points_dedact_from_death = 250
#checkpoint
@export var checkpoint = Vector2(384, 384)
# for death animation
var is_alive = true

func _physics_process(delta):
	#for death animation
	if is_alive == false:
		$"shaul anime".modulate.a = max($"shaul anime".modulate.a - 0.01, 0.0)
		move_and_slide()
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle Jump.
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_select")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$jump_sound.play()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction: velocity.x = direction * SPEED
	else: velocity.x = move_toward(velocity.x, 0, SPEED)
	# Animations
	if velocity.x >= 0.1: 
		$"shaul anime".play("running")
		$"shaul anime".flip_h=false
	elif velocity.x < -0.1:
		$"shaul anime".play("running")
		$"shaul anime".flip_h=true
	else:
		$"shaul anime".play("idle")
		
	# Death by falling
	if position.y > 600:
		death()
		
	move_and_slide()

# moves from door
func move_to(pos):
	position = pos
	checkpoint = pos
	
# dies by mob
func death():
	#add a cool animation of death
	if get_parent().get_node("CanvasLayer").lives <= 0:
		death_animation()
		return
	
	get_parent().get_node("CanvasLayer").live_sub()
	print("DA PAPA died!! -" + str(points_dedact_from_death) + " points!")
	if points >= points_dedact_from_death:
		points -= points_dedact_from_death
		# makes global points 
		Global.points -= points_dedact_from_death
	else: 
		points = 0
	print("Points: " + str(points))
	get_parent().get_node("CanvasLayer").update_points(points)
	
	if is_alive == true:
		position = checkpoint
	
# cool death animation
func death_animation():
	$loss_sound.play()
	velocity.x = 0
	is_alive = false
	#$"player collision".disabled = true
	$"shaul anime".play("dead")
	velocity.y = JUMP_VELOCITY/2
	await get_tree().create_timer(1.5).timeout
	is_alive =true
	get_tree().change_scene_to_file("res://scenes/other/start_screen.tscn")
	
# jumps on mobs
func double_jump():
	velocity.y = JUMP_VELOCITY
	$illay_stomped_sound.play()

# gets the guitar 
func get_guitar():
	get_parent().get_node("ariel_be_like").death()


