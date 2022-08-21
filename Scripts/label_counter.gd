extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time_start = 0
var time_now = 0
var pa
var pb

func _ready():
	time_start = OS.get_unix_time()

func _process(delta):
	time_now = OS.get_unix_time()-time_start
	pa = str(time_now/60)
	pb = str(time_now%60)
	if len(pa)<2:
		pa = "0"+pa
	if len(pb)<2:
		pb = "0"+pb
	self.text = "#REC "+pa+":"+pb
	pass
