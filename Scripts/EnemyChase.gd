extends KinematicBody

export var speed = 10

var path = []
var curr_path_idx = 0
var target = null
var velocity = Vector3.ZERO
var foundPlayer

onready var nav = get_parent()
export var isMoving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(owner, "ready")
	target = owner.player
	pass # Replace with function body.

func _physics_process(delta):
	if path.size()>0 and foundPlayer:
		move_to_target()

func move_to_target():
	if global_transform.origin.distance_to(path[curr_path_idx]) <.1:
		path.remove(0)
	else:
		var direction = path[curr_path_idx] - global_transform.origin
		velocity = direction.normalized() * speed
		move_and_slide(velocity, Vector3.UP)
		for index in get_slide_count():
			var col = get_slide_collision(index)
			if col.collider.is_in_group("Player"):
				get_tree().change_scene("res://Scenes/Death.tscn")

func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)

func _on_Area_body_entered(body):
	if(body.is_in_group("Player")):
		print("EnteredChaser")
		isMoving = true
		foundPlayer = body

func _on_Area_body_exited(body):
	if(body.is_in_group("Player")):
		print("ExitedChaser")
		isMoving = false
		foundPlayer = null

func _on_Timer_timeout():
	get_target_path(target.global_transform.origin)
	pass # Replace with function body.
