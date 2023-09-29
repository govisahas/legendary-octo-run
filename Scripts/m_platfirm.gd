extends Node2D

#creating the moving platform
var moving = false



func _on_area_2d_area_entered(area):
	if  !moving:
		moving = true
		$AnimatableBody2D/AnimationPlayer.play("Moving")
