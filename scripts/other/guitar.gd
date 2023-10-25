extends Area2D

@export var point_amount_from_guitar = 5000

# make the guitar disapear and get coins from it 
# make it kill the miniboss
func _on_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		$coinsound.play()
		self.visible = false
		await get_tree().create_timer(0.3).timeout
		print(str(point_amount_from_guitar) + " points!")
		body.points += point_amount_from_guitar
		
		var points = body.points
		get_parent().get_node("CanvasLayer").update_points(points)
		
		get_parent().get_node("DA SHAUL").get_guitar()
		
		queue_free()
		
