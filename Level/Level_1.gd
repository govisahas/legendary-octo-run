extends Node2D

var totalGems = 0
var GemScene =  preload("res://gem/gem.tscn")

func _ready():
	var level_name = get_name() 
	print(level_name)  # Get the name of the current level scene
	if level_name.begins_with("Level_"):
		var level_number = int(level_name.substr(6)) 
		# Extract the level number
		totalGems = calculate_total_gems(level_number)
		place_gems()
	else:
		print("Level name doesn't match the convention.")
		# Handle levels with non-standard names or other cases


func place_gems():
	for i in range(totalGems):
		var gem_instance = GemScene.instantiate()  # Instantiate a coin from the Coin scene
		gem_instance.position = Vector2(randi() % 2600, randi() % 40)  # Random position within the level
		add_child(gem_instance)  # Add the coin to the level scene


func calculate_total_gems(Level):
	match Level:
		1:
			return  50
		2:
			return  60
		# Add more cases for other levels as needed
