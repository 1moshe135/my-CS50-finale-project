extends Area2D

@export var point_amount_from_coins = 1000
	
func _on_coin_collision_area_entered(coin_collision):
	if coin_collision.is_in_group("PlayerGroup"):
		$coinsound.play()
		self.visible = false
		await get_tree().create_timer(0.3).timeout
		print(str(point_amount_from_coins) + " points!")
		coin_collision.points += point_amount_from_coins
		
		var points = coin_collision.points
		Global.points += point_amount_from_coins
		get_parent().get_node("CanvasLayer").update_points(point_amount_from_coins)
		
		queue_free()
		
