extends Node2D

@export var start_point = Vector2(0, 0)
@export var end_point = Vector2(0, 0)
@export var speed = 0

var direction = 1  # 1 for moving from start to end, -1 for moving back

func _ready():
	pass

func _physics_process(delta):
	var delta_position = speed * direction * delta
	
	# Update the platform's position based on the current direction
	position.x += delta_position
	
	# Check if the platform has reached the end point or the start point
	if direction == 1 and position.x >= end_point.x:
		position.x = end_point.x
		direction = -1
	elif direction == -1 and position.x <= start_point.x:
		position.x = start_point.x
		direction = 1
		
	
