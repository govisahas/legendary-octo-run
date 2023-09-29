extends CharacterBody2D
signal died
signal  hp_changed(new_hp)
signal hp_max_changes(new_hp_max)
var speed = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var current_level
var chase  = false
var death = false
@export var HIT:PackedScene = null

@onready var anim  = get_node("AnimationPlayer")
@export var defence:int = 0
@onready var healthbar = $Healthbar

@export var hp_max:int =100:
	set(value):
		if hp_max != value:
			hp_max = max(0,value)
			emit_signal("hp_max_changed", hp_max)
			healthbar.max_value = hp_max
			self.hp = hp
	get:
		return hp_max
#new way of wring getter and setter
@export var hp:int=100:
	set(value):
		if value !=hp:
			hp = clamp(value,0,hp_max)
			emit_signal("hp_changed",hp) 
			healthbar.value = hp
		if hp <= 0:
			death = true
			emit_signal("died")
		elif hp !=hp_max:
			healthbar.show()
					
			
	get:
		return hp
		


func _physics_process(delta):
	velocity.y += gravity * delta
	
	if chase == true :
		get_node("AnimatedSprite2D").play("Run")
		player =get_node("../../Player/Player2")
		current_level  = get_tree().current_scene.name
		#print(current_level)
		var direction =   (player.position - self.position).normalized()
		
		#print(direction)
		if current_level == "LevelTwo":
			if direction.x > 0.9:
				get_node("AnimatedSprite2D").flip_h = false
				velocity.x = direction.x * speed
			
			else:
				var Direction = -1
				get_node("AnimatedSprite2D").flip_h = true
				velocity.x = direction.x * speed * Direction
				
		else:
					
			if direction.x >0:
				get_node("AnimatedSprite2D").flip_h = false
				velocity.x = direction.x * speed
			else:
				get_node("AnimatedSprite2D").flip_h = true
				velocity.x = direction.x * speed
		
			
		
	else:
		if death  == false:
			get_node("AnimatedSprite2D").play("Idle")
			velocity.x =0
		else:
			get_node("AnimatedSprite2D").play("Death")
		
	move_and_slide()


	


func _on_player_detection_body_exited(body):
	if body.name =="Player2":
		chase = false




func receive_damage(base_damage:int):
	
	var actual_damage  = base_damage
	actual_damage -= defence
	self.hp -=actual_damage
	#print(name  + "recieved" + str(actual_damage) + "damage")
	
	

func _on_hurtbox_area_entered(Hitbox):
	
	var damage  = 20
	print(Hitbox.damage)
	receive_damage(damage)
	
	if Hitbox.is_in_group("Fire"):
		Hitbox.destroy()
	spawn_effect(HIT)

func _on_died():
	print("died")


func _on_animated_sprite_2d_animation_finished():
	#print("animation finished")
	
	if $AnimatedSprite2D.animation == "Idle":
		if death == true:
			queue_free()
	


func _on_player_detection_body_entered(body):
	if body.name  == "Player2":
		chase =true
		player =get_node("../../Player/Player2")
		#print(player.global_position)
	
	

func _on_animation_player_animation_finished(anim_name):
	#print("enter")
	if anim_name == "Death":
		Core.enemyDeath +=Core.enemyDeath
		#print(Core.enemyDeath)
		queue_free()
		




#adding effect of hurt to the enemy
func spawn_effect(EFFECT:PackedScene, effect_position:Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		


func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation == "Death":
		Core.enemyDeath = Core.enemyDeath+1
		#print(Core.enemyDeath)
		queue_free()
