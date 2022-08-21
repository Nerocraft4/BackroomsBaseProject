extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Level0.tscn")


func _on_Quit_pressed():
	get_tree().quit()
