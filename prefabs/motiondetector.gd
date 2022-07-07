extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var scanning = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	$AnimationPlayer.play("RESET")
	pass # Replace with function body.


func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE and event.pressed and scanning==false:
			$AnimationPlayer.play("Raise")
			scanning = true
			$TurnOnDetector.play()
			$Scan.play()
		elif event.scancode == KEY_SPACE and event.pressed and scanning==true:
			$AnimationPlayer.play("Lower")
			scanning = false
			$TurnOffDetector.play()
			$Scan.stop()
