extends Area2D

@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimatedSprite2D.play("bogger_bullet")
	position += Vector2.LEFT * speed * delta

# disappearing after few secs
func _on_timer_timeout():
	queue_free()

#kills player
func kill_player(body):
	if body.is_in_group("PlayerGroup"):
		body.death()
