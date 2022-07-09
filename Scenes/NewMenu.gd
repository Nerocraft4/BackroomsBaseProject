extends Spatial

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
				get_tree().change_scene("res://Scenes/level7.tscn")
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
