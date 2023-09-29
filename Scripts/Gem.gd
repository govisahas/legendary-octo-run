extends Node2D

func _ready():
	$AnimatedSprite2D.play("Gem")
	



func _on_gem_area_body_entered(body):
	if body.name == "Player2":
		$"../../Gemcollect".play()
		queue_free()
		Core.gem_gained(1)

