extends KinematicBody

export var speed = 15 

var direction = Vector3.ZERO
var foundPlayer = null
var movement = Vector3()
var h_velocity = Vector3()
var h_acceleration = 30
onready var dragsound = $Drag

export var isMoving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if foundPlayer and not "EnemyStatue" in foundPlayer.looking_at:
		if !dragsound.playing:
			dragsound.play()
		direction = foundPlayer.transform.origin - transform.origin
		var facing = transform.basis.z
		direction.y=0
		var diff = direction.normalized()-facing
		rotation.y = lerp_angle(rotation.y, atan2(diff.x,diff.z),delta*7)
		h_velocity=h_velocity.linear_interpolate(transform.basis.z*speed, h_acceleration*delta)
		movement.z = h_velocity.z
		movement.x = h_velocity.x
		move_and_slide(movement, Vector3.UP)
		for index in get_slide_count():
			var col = get_slide_collision(index)
			if col.collider.is_in_group("Player"):
				get_tree().change_scene("res://Scenes/NewMenu.tscn")
		var ndir = norm(direction)
	elif dragsound.playing:
		dragsound.stop()

func norm(v):
	return sqrt(v.x*v.x+v.y*v.y+v.z*v.z)


func _on_Area_body_entered(body):
	if(body.is_in_group("Player")):
		print("Entered")
		foundPlayer = body
		isMoving = true
	pass # Replace with function body.


func _on_Area_body_exited(body):
	if(body.is_in_group("Player")):
		print("Exited")
		foundPlayer = null
		isMoving = false
	pass # Replace with function body.
