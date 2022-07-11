extends KinematicBody

#globals or something
var save_filename = "user://save_game.save"
var gravity = 9.8
var grounded = true
var mouse_sensitivity = 0.10

#preloads
onready var head = $Head
onready var head_x = $Head/HeadRotationX
onready var anim_play = $Head/HeadRotationX/Camera/AnimationPlayer
onready var bar = $Head/HeadRotationX/Camera/CanvasLayer/ProgressBar
onready var FL = $Head/HeadRotationX/SpotLight

#scene preloads (main menu and death screen ig?)

#item holding
onready var reach = $Head/HeadRotationX/Camera/Reach
onready var lefthand = $Head/HeadRotationX/LeftHand
onready var righthand = $Head/HeadRotationX/RightHand

#items
onready var motiondetector = preload("res://prefabs/motiondetector.tscn")
onready var motionLR = preload("res://prefabs/MotionLowRes.tscn")
onready var flasher = preload("res://prefabs/Flasher.tscn")
onready var flasherLR = preload("res://prefabs/FlasherLowRes.tscn")
var tospawn = null

#physical stats
export var max_stamina = 1000
export var stamina = 100
export var stamina_regen = 1
export var speed = 10
var run = 1
var h_acceleration = 18
var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()

#item stats
var max_flashes = 20
var flashes

#macro stats
export var secrets = 0
var current_checkpoint

func _ready():
	var save_file = File.new()
	save_file.open(save_filename,File.READ)
	var node_data = parse_json(save_file.get_line())
	load_save_stats(node_data)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotation_degrees.y -= mouse_sensitivity*event.relative.x
		head_x.rotation_degrees.x -= mouse_sensitivity*event.relative.y
		head_x.rotation_degrees.x = clamp(head_x.rotation_degrees.x, -89, 89)
	if event is InputEventKey and event.pressed:
		if lefthand.get_child_count()==1 and event.scancode == KEY_F and flashes > 0:
			flashes -= 1
			lefthand.get_child(0).set_flashes(flashes,max_flashes)
			lefthand.get_child(0).flash()
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/NewMenu.tscn")

func _process(delta):
	if !tospawn:
		if reach.is_colliding():
			if reach.get_collider().get_name() == "FlasherLowRes":
				tospawn = flasher.instance()
			elif reach.get_collider().get_name() == "MotionLowRes":
				tospawn = motiondetector.instance()
			elif reach.get_collider().get_name() == "Checkpoint":
				SaveState.save_game()
			else:
				tospawn = null
		else:
			tospawn = null
		
	if Input.is_action_just_pressed("interact"):
		if tospawn != null:
			print("aquired item")
			reach.get_collider().queue_free()
			if tospawn.get_name() == "Flasher":
				tospawn.rotation = lefthand.rotation
				lefthand.add_child(tospawn)
				tospawn = null
			else:
				print("Added MotionDetector")
				tospawn.rotation = righthand.rotation
				righthand.add_child(tospawn)
				tospawn = null

func _physics_process(delta):	
	var head_basis = head.get_global_transform().basis
	direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	if Input.is_action_pressed("control") and stamina>0 and direction!=Vector3():
		run = 2
		stamina -= 2*stamina_regen
	else:
		run = 1
		if stamina<max_stamina:
			stamina += 1*stamina_regen
	bar.value = stamina
	
	direction = direction.normalized()	
	h_velocity = h_velocity.linear_interpolate(direction*speed*run, h_acceleration*delta)
	movement.z = h_velocity.z
	movement.x = h_velocity.x
	if is_on_floor():
		movement.y = 0
	movement.y -= 2 * gravity * delta
	move_and_slide(movement, Vector3.UP)

	if direction != Vector3():
		anim_play.play("HeadBob")
		if run!=1:
			if !$RunSound.playing:
				$RunSound.play()
				$WalkSound.stop()
			if !$HeavyBreathingSound.playing:
				$HeavyBreathingSound.play()
				$BreathingSound.stop()
		else:
			if !$WalkSound.playing:
				$WalkSound.play()
				$RunSound.stop()
			if !$BreathingSound.playing:
				$BreathingSound.play()
				$HeavyBreathingSound.stop()
	else:
		$WalkSound.stop()
		$RunSound.stop()
		$HeavyBreathingSound.stop()
		anim_play.play("RESET")

func _on_Area_area_entered(body):
	if(body.is_in_group("Terrain")):
		print("Grounded")
		grounded = true

func _on_Area_area_exited(body):
	if(body.is_in_group("Terrain")):
		print("Airborne")
		grounded = false

func get_save_stats():
	return {
		'filename':get_filename(),
		'current_scene':get_tree().current_scene.filename,
		'xpos':global_transform.origin.x,
		'ypos':global_transform.origin.y,
		'zpos':global_transform.origin.z,
		'checkpoint':current_checkpoint,
		'stats':{
			'stamina':stamina,
			'flashes':flashes,
			'secrets':secrets,
			'hasFlasher':lefthand.get_child_count(),
			'hasTracker':righthand.get_child_count()
		}
	}

func load_save_stats(stats):
	global_transform.origin = Vector3(stats.xpos,stats.ypos,stats.zpos)
	stamina = stats.stats.stamina
	flashes = stats.stats.flashes
	secrets = stats.stats.secrets
	current_checkpoint = stats.checkpoint
	if stats.stats.hasFlasher==1:
		tospawn = flasher.instance()
		tospawn.rotation = lefthand.rotation
		lefthand.add_child(tospawn)
		tospawn = null
		lefthand.get_child(0).set_flashes(flashes,max_flashes)
	if stats.stats.hasTracker==1:
		tospawn = motiondetector.instance()
		tospawn.rotation = righthand.rotation
		righthand.add_child(tospawn)
		righthand.get_child(0).onload_with_player()
		tospawn = null
	
