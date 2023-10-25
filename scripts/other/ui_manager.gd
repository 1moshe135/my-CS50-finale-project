extends CanvasLayer

var time = 0.0
@export var max_lives = 5
@export var lives = 5
@export var precent = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	updateTimerLabel()

func updateTimerLabel():
	var minutes = int(time / 60)
	var seconds = int(int(time) % 60)
	$Time.text = String("%02d:%02d" % [minutes, int(seconds)])

func update_points(points):
	$Points.text = "points: " + str(points)
	
func live_sub():
	lives -= 1
	print("life substructed " + str(lives))
	
	#death
	if lives == 0:
		get_parent().get_node("DA SHAUL").death_animation()
		lives = max_lives
		
	$live_loss.play()
	$Lives.set_size(Vector2(precent*lives, 16))
