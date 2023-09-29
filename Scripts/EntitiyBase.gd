extends CharacterBody2D


@export var SPEED:int =75

@onready var sprites = $Sprite2D
@onready var collShape  = $CollisionShape2D
@onready var animPlayer = $AnimationPlayer



	
	
	
func die():
	queue_free()
