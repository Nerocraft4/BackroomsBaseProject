extends KinematicBody

var mouse_sensitivity = 0.10

onready var head = $Head
onready var head_x = $Head/HeadRotationX
onready var anim_play = $Head/HeadRotationX/Camera/AnimationPlayer
onready var flashlight = $Flashlight
onready var flashlight_light = $Flashlight/Flashlight_light
const FL_SPEED = 15

export var speed = 10
var run = 1
var h_acceleration = 18
var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 

func _input(event):
	if event is InputEventMouseMotion:
		head.rotation_degrees.y -= mouse_sensitivity*event.relative.x
		head_x.rotation_degrees.x -= mouse_sensitivity*event.relative.y
		head_x.rotation_degrees.x = clamp(head_x.rotation_degrees.x, -89, 89)
	if event is InputEventKey:
		if event.scancode == KEY_F and event.pressed:
			flashlight_light.visible = !flashlight_light.visible
			$Click.play()

func _physics_process(delta):
	make_flashlight_follow(delta)
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
	if Input.is_action_pressed("control"):
		run = 2
	else:
		run = 1
		
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction*speed*run, h_acceleration*delta)
	movement.z = h_velocity.z
	movement.x = h_velocity.x
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

func make_flashlight_follow(delta):
	flashlight.rotation.y = lerp(flashlight.rotation.y, head.rotation.y, delta*FL_SPEED)
	flashlight.rotation.x = lerp(flashlight.rotation.x, head_x.rotation.x, delta*FL_SPEED)
