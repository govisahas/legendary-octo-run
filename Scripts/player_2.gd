extends CharacterBody2D
@export var Fire = preload("res://Scenes/playerFire.tscn")
signal died
signal  hp_changed(new_hp)
signal hp_max_changes(new_hp_max)
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var death= false

@onready var healthbar = $Healthbar
@export var HIT:PackedScene = null
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
		
@export var defence:int = 0
var isAttacking  = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim  = get_node("AnimationPlayer")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		$Jump.play()

	# Get the input direction and handle the movement/deceleration.

	
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Right", "Left") 
	if direction ==-1:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
	if direction: 
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y ==0:
			if isAttacking == false && death ==false:
				anim.play("Idle")
			if death == true:
				anim.play("Death")
				$PlayerDead.play()
				Core.playerDeath = true

	if Input.is_action_just_pressed("Attack"):
		anim.play("Attack")
		var fire_direction =self.global_position.direction_to(get_global_mouse_position())
		throwFire(fire_direction)
		
		
		isAttacking = true
		
		
	move_and_slide()
	
func receive_damage(base_damage:int):
	var actual_damage  = base_damage
	actual_damage -= defence
	self.hp -=actual_damage
	#print(name  + "recieved" + str(actual_damage) + "damage") 



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		isAttacking =false
	


func _on_died():
	print("player died") 


func throwFire(fire_direction:Vector2):
	if Fire:
		var fire = Fire.instantiate()
		get_tree().current_scene.add_child(fire)
		fire.global_position = self.global_position
		
		var fire_rotation = fire_direction.angle()
		fire.rotation = fire_rotation


#adding effect of hurt to the enemy
func spawn_effect(EFFECT:PackedScene, effect_position:Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		




func _on_hurtbox_area_entered(hitbox):
	var damage  = hitbox.damage  
	print(hitbox.get_parent())                
	receive_damage(damage)
	spawn_effect(HIT)

