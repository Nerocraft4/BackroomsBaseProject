extends Spatial

onready var label = $Viewport/Label
onready var anim_flash = $FlashPlayer

func _ready():
	pass # Replace with function body.

func set_flashes(flashes,max_flashes):
	label.text = str(flashes)+"/"+str(max_flashes)
func flash():
	anim_flash.play("Flash")
	
