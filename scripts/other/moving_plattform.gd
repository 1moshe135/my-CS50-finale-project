extends Node2D

@export var start_point = Vector2(0, 0)
@export var end_point = Vector2(0, 200)
@export var speed = 0

var direction = 1  # 1 for moving from start to end, -1 for moving back

func _ready():
	pass

func _physics_process(delta):
	var delta_position = speed * direction * delta
	
	# Update the platform's position based on the current direction
	position.y += delta_position
	
	# Check if the platform has reached the end point or the start point
	if direction == 1 and position.y >= end_point.y:
		position.y = end_point.y
		direction = -1
	elif direction == -1 and position.y <= start_point.y:
		position.y = start_point.y
		direction = 1
