extends "FlyingObject.gd"

signal shoot

export (int) var rotation_factor
export (float) var thrust_factor

var t_shot = 0
var waitingForImmuneStop = false
var t_immune = 0

func _ready():
	playAnimation("default")
	
	#Changes to FlyingObject variables specific to Ship
	objectSize=Vector2(44,44)
	drag = true
	setActive(true)

func _process(delta):
	if running:
		#Immunity deactivation
		if waitingForImmuneStop and OS.get_system_time_msecs()-t_immune>3000:
			setImmune(false)
		
		#Rotation
		if Input.is_action_pressed("ship_left"):
			rotation_degrees-=delta*rotation_factor
		elif Input.is_action_pressed("ship_right"):
			rotation_degrees+=delta*rotation_factor
		
		#Thrusting
		if Input.is_action_pressed("ship_thrust"):
			speed+=Vector2(sin(rotation),cos(rotation))*thrust_factor
			playAnimation("boost")
		else:
			playAnimation("default")
		
		#Firing
		if Input.is_action_pressed("ship_shoot") and OS.get_system_time_msecs()-t_shot>333:
			emit_signal("shoot")
			t_shot=OS.get_system_time_msecs()

func setActive(active):
	running = active
	$AnimatedSprite.visible = active #TODO instead of disabling, play a death animation
	setImmune(!active)

func setImmune(immune):
	$CollisionShape2D.call_deferred("set_disabled", immune)
	t_immune = OS.get_system_time_msecs()
	waitingForImmuneStop = true