extends "FlyingObject.gd"

signal hit_ship
signal split

export (int) var max_speed
export (int) var max_rotation_speed

#Asteroid size should range from 0 to 3 -> 4 sizes
var asteroidSize = 3

func _ready():
	#Connect signals to parent
	connect("split", get_parent(), "_on_Asteroid_split")
	connect("split", get_parent(), "_on_Asteroid_split")
	randomize()
	
	var animation=int(rand_range(0,3))
	playAnimation(String(animation))
	
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
	$CollisionShape2D.scale=Vector2(scaleFactor,scaleFactor)
	$CollisionArea/AreaShape.scale=Vector2(scaleFactor,scaleFactor)


func _on_CollisionArea_body_entered(body):
	print("Collision with "+body.get_name())
	if body.get_name()=="Ship":
		emit_signal("hit_ship")
	elif "Shot" in body.get_name():
		body.kill() #Destroy shot
		if asteroidSize>0:
			emit_signal("split", self)
		queue_free()
