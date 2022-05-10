extends Spatial

var size = 36
var BS = 12
var difficulty = 7
var k = 0
var rng = RandomNumberGenerator.new()
onready var LightSource = preload("res://Prefabs/Light2.tscn")
var light

func _ready():
	generate_Lights_Around(0,0,size)
	pass 
	
func generate_Lights_Around(a,b,size):
	for x in range(size):
		for z in range(size):
			rng.randomize()
			k = rng.randi_range(0,100)
			if x%2==0 and z%2==0:
				light = LightSource.instance()
				light.translation = Vector3(x*BS-(size-1)/2*BS,4.94,z*BS-(size-1)/2*BS)
				light.rotate_object_local(Vector3(0, 0, 1), PI)
				add_child(light)
