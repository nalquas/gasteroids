extends "FlyingObject.gd"

export (int) var max_speed
export (int) var max_rotation_speed

#Asteroid size should range from 0 to 3 -> 4 sizes
var asteroidSize = 3

func _ready():
	playAnimation("0")
	randomize()
	
	#Changes to FlyingObject variables specific to Asteroid
	setSize(asteroidSize)
	setSpeedByDirection(rand_range(0,360),rand_range(max_speed/5,max_speed))
	speedRotation=rand_range(-max_rotation_speed,max_rotation_speed)
	running = true

func setSize(newSize):
	asteroidSize=newSize
	
	var scaleFactor = 1.0/(4-asteroidSize)
	objectSize=Vector2(131*scaleFactor,131*scaleFactor)
	$AnimatedSprite.scale=Vector2(scaleFactor,scaleFactor)

