extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Replay_button_down():
	get_tree().change_scene("res://Scenes/Video.tscn")


func _on_Eject_button_down():
	get_tree().quit()
