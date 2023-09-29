extends Node2D




func _on_checkpont_area_body_entered(body):
	if body.name == "Player2"  && Core.gems==40 && Core.enemyDeath == 2:
		Core.enemyDeath = 0
		$NextLevelD.play()		
		get_tree().change_scene_to_file("res://Level/Level_2.tscn")
		Core.gems = 0
		
	
	
	if body.name == "Player2" && Core.gems == 50 && Core.enemyDeath == 3:
		Core.enemyDeath = 0
		$NextLevelD.play()
		get_tree().change_scene_to_file("res://Level/Level_3.tscn")
		Core.gems = 0
			
	if body.name == "Player2" && Core.gems == 60 && Core.enemyDeath == 4:
		print("Enter to the body")
		print(Core.enemyDeath)
		$NextLevelD.play()
		Core.gameFinish = true
		
	
