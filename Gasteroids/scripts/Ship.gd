extends "FlyingObject.gd"

signal shoot

export (int) var rotation_factor
export (float) var thrust_factor

var t_shot = 0
var waitingForImmuneStop = false
var t_immune = 0
var doShrinking = false

func _ready():
	playAnimation("default")
	$AnimatedSprite.scale=Vector2(0.33,0.33)
	
	#Changes to FlyingObject variables specific to Ship
	objectSize=Vector2(44,44)
	drag = true
	setActive(true)
	setImmune(true)

func _process(delta):
	if doShrinking:
		#Play Shrinking animation on death
		$AnimatedSprite.scale -= Vector2(delta,delta)/4
		if $AnimatedSprite.scale.x<=0:
			doShrinking = false
			$AnimatedSprite.scale=Vector2(0,0)
	
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
			if waitingForImmuneStop:
				playAnimation("boost_immune")
			else:
				playAnimation("boost")
		else:
			if waitingForImmuneStop:
				playAnimation("default_immune")
			else:
				playAnimation("default")
		
		#Firing
		if Input.is_action_pressed("ship_shoot") and OS.get_system_time_msecs()-t_shot>333:
			emit_signal("shoot")
			t_shot=OS.get_system_time_msecs()

func setActive(active):
	running = active
	#$AnimatedSprite.visible = active #TODO instead of disabling, play a death animation
	if !active:
		playAnimation("destroyed")
		doShrinking = true
	else:
		doShrinking = false
		$AnimatedSprite.scale=Vector2(0.33,0.33)
	setImmune(!active)

func setImmune(immune):
	$CollisionShape2D.call_deferred("set_disabled", immune)
	waitingForImmuneStop = immune
	if immune:
		t_immune = OS.get_system_time_msecs()