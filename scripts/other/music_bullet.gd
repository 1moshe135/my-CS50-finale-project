extends Area2D

@export var speed = 150
var shaul_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimatedSprite2D.play("muzic")
	shaul_pos = give_pos()
	position = position.move_toward(shaul_pos , speed * delta)  

# disappearing after few secs
func _on_timer_timeout():
	queue_free()

#kills player
func kill_player(body):
	if body.is_in_group("PlayerGroup"):
		body.death()

#return the shaul position
func give_pos() -> Vector2:
	shaul_pos = get_parent().get_node("DA SHAUL").position
	return shaul_pos
