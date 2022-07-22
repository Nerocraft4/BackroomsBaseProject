extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save_filename = "user://save_game.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_VideoPlayer_finished():
	playGame()
	pass # Replace with function body.

func playGame():
	var file2Check = File.new()
	var doFileExists = file2Check.file_exists(save_filename)
	if !doFileExists:
		print("No save file. Writing initial data")
		file2Check.open(save_filename,File.WRITE)
		file2Check.store_line(to_json({
		'filename':'res://prefabs/Player.tscn',
		'current_scene':'res://Scenes/level0.tscn',
		'xpos':0,
		'ypos':0.2,
		'zpos':0,
		'checkpoint':0,
		'stats':{
			'stamina':1000,
			'flashes':20,
			'secrets':0,
			'hasFlasher':0,
			'hasTracker':0
		}
	}))
		file2Check.close()
		get_tree().change_scene("res://Scenes/level0.tscn")
	else:
		print("Found save file")
		print("Loading...")
		file2Check.open(save_filename,File.READ)
		var data = parse_json(file2Check.get_line())
		get_tree().change_scene(data.current_scene)
