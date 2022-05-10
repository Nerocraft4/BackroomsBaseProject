extends MultiMeshInstance

export var size = 9
var BS = 12
var SS = 1
var b = transform.basis.rotated(Vector3(0,0,1), PI)

func _ready():
	self.multimesh.instance_count = size*size
	for x in range(size):
		for z in range(size):
			self.multimesh.set_instance_transform(size*x+z, 
			Transform(b, Vector3(x*BS-(size-1)/2*BS,5,z*BS-(size-1)/2*BS)))
