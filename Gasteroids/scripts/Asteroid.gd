extends "FlyingObject.gd"

signal hit_ship
signal split
signal destroyed

export (int) var max_speed
export (int) var max_rotation_speed

#Asteroid size should range from 0 to 3 -> 4 sizes
var asteroidSize = 3

func _ready():
	#Grouping
	add_to_group("asteroids")
	
	#Connect signals to parent
	#warning-ignore:return_value_discarded
	connect("hit_ship", get_parent(), "_on_Asteroid_hit_ship")
	#warning-ignore:return_value_discarded
	connect("split", get_parent(), "_on_Asteroid_split")
	#warning-ignore:return_value_discarded
	connect("destroyed", get_parent(), "_on_Asteroid_destroyed")
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
	
	var scaleFactor = 1.25/(4-asteroidSize)
	objectSize=Vector2(131*scaleFactor,131*scaleFactor)
	$AnimatedSprite.scale=Vector2(scaleFactor,scaleFactor)
	$CollisionShape2D.scale=Vector2(scaleFactor,scaleFactor)
	$CollisionArea/AreaShape.scale=Vector2(scaleFactor,scaleFactor)

func destroySelf():
	if asteroidSize>1:
		emit_signal("split", self)
	emit_signal("destroyed")
	queue_free() #Destroy self

func _on_CollisionArea_body_entered(body):
	if body.get_name()=="Ship":
		emit_signal("hit_ship", self)
		destroySelf()
	elif "Shot" in body.get_name():
		body.kill() #Destroy shot
		destroySelf()
