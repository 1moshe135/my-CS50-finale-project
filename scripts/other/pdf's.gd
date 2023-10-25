extends Area2D

@export var speed: float = 500.0
var shaul_angle: float
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	direction = ( get_parent().get_node("DA SHAUL").position - self.position ).normalized()
	$Timer.start()
	look_at(get_parent().get_node("DA SHAUL").position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	$AnimatedSprite2D.play("muzic")
	
	position = position.lerp(position + direction, speed * delta)

# Disappearing after a few seconds
func _on_timer_timeout():
	queue_free()

# Kills the player
func kill_player(body: Node):
	if body.is_in_group("PlayerGroup"):
		body.death()

