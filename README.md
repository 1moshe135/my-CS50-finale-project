# my CS50 finale project
#### Video Demo:  <https://youtu.be/k9QzfovHceI>
#### Link for web playing at itch.io: <https://1moshe135.itch.io/my-cs-50-finale-project>

#### * sorry if the git looks short. i spent a lot of time to write a 6 page one, but because of reloading the changes weren't saved. :(

## IMPORTANT!
*the game works only on non-mac computers and require keyboard!
*the assets.zip file need to be extructed before downloading the game in order for it to work!
*the game is much better with sound on! play only if you are ok with getting fraustrated >:3

## project background

Hello! I'm Moshe, and this is my CS-50 X finale project!
For my project, I decided to create something I've been wanting to do with a friend for quite a while. It all started when I became a programming teacher, and I didn't feel assured that I had all the tools I needed. That's when my journey began.
After a few months of learning random languages and working on basic projects, he suggested I try CS-50, and I did!
Once I completed the course, I knew exactly what to choose for this task. The kids in my classroom actually helped me with ideas for this game, and we based the characters on us and themselves.
The game features three main levels, a mini-boss, and a final boss fight. It includes all sorts of funny sounds, graphics, and different mobs with cool mechanics!

To play this game, simply press the play button. Thank you, and this marks the completion of my CS-50 journey.

recommended controls:

*to move right : D

*to move left:  A

*to jump: mouse_click

please enjoy the game and comment to share your thoughts!!

## file exploration

* scenes - has all the static scenes, AKA levels, boss fights ..
* assets - has all the assets and recources for the game. textures, images, tilesets, sounds, and more
* charecters - has all of the entities in the game. bosses, minibosses, regular mobs and the player scenes
* scripts - has all the scripts and codes for every aspect of the game (of course, orgenized.)
* export - has the template and index.html of the game that was uploaded to itch.io
* global.gd - a special script that is external to all files in order to run un the background and count the final score of the player in the game.
* exports_presets - an engine file belongs to godot 4 that make an html 5 game with some dark magic.
* README.md - whats youre reading right now :3
* (also includes the godot logo because of the engine.)


## code
#### this project was build in the godot 4 engine with the language gd.script which is like the python learned in the course.
### 'charecters' -> 'player' -> 'DA SHAUL.tscn' OR 'scripts' -> 'charecters' -> 'player' -> 'da_shaul.gd'

the language gd script has some functions built into it. the main and important one in most of the scripts written for the game is

### _physics_proccess()

it runs endlessly when the script is called into some scene. that makes this file ideal for listening for input, moving and animation of the charecters and items!

now lets dive into this function inside the main player script:

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

I also added comments on every code in order to explain it.

now lets look at the functions that i built for the main charecter:

this one is making the charecter to teleport in certain point in 2D space.
    
    func move_to(pos):
      position = pos
	    checkpoint = pos
	
this one is what happens when the player is touching a mob and needs to trigger death

    func death():
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
    	
this it the cool death animation:

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

this is when he jumps on a mob and gets a double jump:
          
    func double_jump():
      	velocity.y = JUMP_VELOCITY
      	$illay_stomped_sound.play()

and lastly, this one is for a special scene when he gets a certain item that kills the mini boss

    func get_guitar():
    	get_parent().get_node("ariel_be_like").death()
    

### thank you for reading this far! i hope that this file is answering the need. please have fun and try to play the game in itch.io at the link above!
