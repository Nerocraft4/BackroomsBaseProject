extends KinematicBody

var gravity = 9.8
var grounded = true
var mouse_sensitivity = 0.10

onready var head = $Head
onready var head_x = $Head/HeadRotationX
onready var anim_play = $Head/HeadRotationX/Camera/AnimationPlayer
onready var bar = $Head/HeadRotationX/Camera/CanvasLayer/ProgressBar
onready var FL = $Head/HeadRotationX/SpotLight
onready var FTimer = $Timer

export var max_stamina = 1000
export var stamina = 100
export var stamina_regen = 1
export var speed = 10

var run = 1
var h_acceleration = 18
var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	stamina = max_stamina

func _input(event):
	if event is InputEventMouseMotion:
		head.rotation_degrees.y -= mouse_sensitivity*event.relative.x
		head_x.rotation_degrees.x -= mouse_sensitivity*event.relative.y
		head_x.rotation_degrees.x = clamp(head_x.rotation_degrees.x, -89, 89)
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_F:
			FL.show()
			FTimer.start()

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
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
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

func _on_Timer_timeout():
	FL.hide()
