extends "FlyingObject.gd"

export (int) var rotation_factor
export (float) var thrust_factor

func _ready():
	playAnimation("default")
	
	#Changes to FlyingObject variables specific to Ship
	objectSize=Vector2(44,44)
	drag = true
	running = true

func _process(delta):
	if running:
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
		if Input.is_action_pressed("ship_shoot"):
			pass
