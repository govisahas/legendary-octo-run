extends Node2D


@export var force = -600.0



func _on_area_2d_body_entered(body):
	if body.name  == "Player2":
		$"../../Player/Player2".velocity.y =force
