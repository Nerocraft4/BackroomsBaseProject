extends KinematicBody

var rng = RandomNumberGenerator.new()
var speed = 6
var direction = Vector3.ZERO
var foundPlayer = null
var movement = Vector3()
var h_velocity = Vector3()
var h_acceleration = 10

onready var envo = get_node("../WorldEnvironment")

func _ready():
	pass

func _physics_process(delta):
	var env = envo.get_environment() 
	if foundPlayer:
		direction = foundPlayer.transform.origin - transform.origin
		var facing = transform.basis.z
		direction.y=0
		var diff = direction.normalized()-facing
		rotation.y = lerp_angle(rotation.y, atan2(diff.x,diff.z),delta*2)
		h_velocity=h_velocity.linear_interpolate(transform.basis.z*speed, h_acceleration*delta)
		movement.z = h_velocity.z
		movement.x = h_velocity.x
		move_and_slide(movement, Vector3.UP)
		for index in get_slide_count():
			var col = get_slide_collision(index)
			if col.collider.is_in_group("Player"):
				get_tree().change_scene("res://Scenes/Menu.tscn")
		var ndir = norm(direction)
		#adjustment_saturation set_adjustment_saturation(value) get_adjustment_saturation()
#		env.set_adjustment_saturation(1+300/(ndir))
#		#env.set_dof_blur_near_distance(4+120/(ndir*ndir))
#		env.set_tonemap_auto_exposure_grey(0.4+40/(ndir))
		envo.set_environment(env)

func _on_Area_body_entered(body):
	if(body.is_in_group("Player")):
		print("Entered")
		foundPlayer = body

func _on_Area_body_exited(body):
	if(body.is_in_group("Player")):
		print("Exited")
		foundPlayer = null

func norm(v):
	return sqrt(v.x*v.x+v.y*v.y+v.z*v.z)
