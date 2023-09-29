extends  Area2D
@export var damage:int =10

@export var SPEED:int = 200

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position +=SPEED*direction * delta
	if Input.is_action_just_pressed("Attack"):
		$AnimatedSprite2D.play("Fire")
		

	
func destroy():
	queue_free()
	
	


func _on_area_entered(area):
	destroy()


func _on_body_entered(body):
	destroy()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

