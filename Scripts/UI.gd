extends CanvasLayer




func _ready():
	Core.pause_menu = $PauseMenu
	Core.winmenu = $WinMenu
	Core.finishMenu = $FinalMenu
	Core.gained_gem.connect(update_gem_display)
	
	if Core.playerDeath == true || Core.gameFinish == true:
		update_score()

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		Core.pause_play()
	if Core.playerDeath == true:
		Core.winmenu.visible = true
		update_score()
	else:
		Core.winmenu.visible = false
	if Core.gameFinish == true:
		Core.finishMenu.visible = true
		update_score()
		
func update_gem_display(gained_gems):
	$TextureRect/Label.text = str(Core.gems)
	

func update_score():
	$WinMenu/Label.text = str(Core.gems)
	$FinalMenu/Label2.text  = str(Core.gems)
	

func _on_resume_pressed():
	Core.resume()


func _on_restart_pressed():
	Core.restart()


func _on_quit_pressed():
	Core.quit()
