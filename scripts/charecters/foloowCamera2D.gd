extends Camera2D

@export var shaul_offset := Vector2(0, 0)
@onready var shaul = get_parent().get_node("DA SHAUL")

# Adjust these values to control the smoothness of the camera movement.
var smoothness = 5.0  # Higher values make the camera follow more smoothly.
var max_speed = 100.0  # Adjust the maximum speed the camera can move.

func _physics_process(_delta):
	var target_x = shaul.position.x + shaul_offset.x
	var current_x = position.x
	
	# Smoothly move the camera towards the target position using lerp.
	position.x = lerp(current_x, target_x, smoothness * _delta)
	
	# Clamp the camera speed to prevent sudden jumps.
	var delta_x = abs(target_x - current_x)
	position.x += clamp(delta_x, -max_speed * _delta, max_speed * _delta)


  
