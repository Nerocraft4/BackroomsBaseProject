extends Spatial

#{"checkpoint":null,"current_scene":"res://Scenes/level0.tscn","filename":"res://prefabs/Player.tscn","stats":{"flashes":20,"hasFlasher":0,"hasTracker":0,"secrets":0,"stamina":1000},"xpos":0.000007,"ypos":0.219225,"zpos":-0.000008}

var save_filename = "user://save_game.save"

var state = 1
onready var hover1 = $Comp/Viewport/hover1
onready var hover2 = $Comp/Viewport/hover2
onready var hover3 = $Comp/Viewport/hover3
onready var beep = $Audios/Beep

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.scancode == KEY_UP or event.scancode == KEY_W:
			beep.play()
			if state>1:
				state-=1
		elif event.scancode == KEY_DOWN or event.scancode == KEY_S:
			beep.play()
			if state<3:
				state+=1
		elif event.scancode == KEY_ENTER:
			if state == 1:
				playGame()
			elif state == 2:
				pass
			elif state == 3:
				get_tree().quit()

func _process(delta):
	if state == 1:
		hover1.show()
		hover2.hide()
		hover3.hide()
	elif state == 2:
		hover1.hide()
		hover2.show()
		hover3.hide()
	elif state == 3:
		hover1.hide()
		hover2.hide()
		hover3.show()
	pass

func _on_Eject_pressed():
	get_tree().quit()
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
