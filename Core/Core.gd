extends Node


signal gained_gem(int)
var gems = 0
var paused = false
var pause_menu
var winmenu
var enemyDeath = 0
var playerDeath 
var gameFinish
var finishMenu
var totalGems = 0
var GemScene  = "res://gem/gem.tscn"



func gem_gained(gained_gem:int):
	gems  = gems+gained_gem
	emit_signal("gained_gem", gained_gem)
	print(gems)
	

func pause_play():
	#flips the value
	paused =! paused
	pause_menu.visible = paused
	
func resume():
	pause_play()
	
func  restart():
	gems=0
	enemyDeath =0
	playerDeath = false
	gameFinish = false
	get_tree().reload_current_scene()
	
func quit():
	playerDeath = false
	get_tree().quit()
	
	




