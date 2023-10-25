extends Node

func _ready():
	$points.text = str("total points: " + str(Global.points))
