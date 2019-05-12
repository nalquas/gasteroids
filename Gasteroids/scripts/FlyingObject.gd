extends KinematicBody2D

var running = false
var speed = Vector2(0,0)
var speedRotation = 0
var drag = false
var objectSize = Vector2(0,0)

func _physics_process(delta):
	if running:
		#Movement
		position.x+=speed.x*delta
		position.y-=speed.y*delta
		rotation_degrees+=speedRotation*delta
		
		#Drag
		if drag:
			speed-=(speed*0.15)*delta
		
		#Looping boundaries
		checkOutOfBounds()

func setSpeedByDirection(direction, newSpeed):
	speed = Vector2(sin(direction),-cos(direction))*newSpeed

func checkOutOfBounds():
	#Adjust for objects being centered around a point
	var usedSize = Vector2(objectSize.x/2, objectSize.y/2)
	
	if position.x<-usedSize.x:
		position.x=1920+usedSize.x
	elif position.x>1920+usedSize.x:
		position.x=-usedSize.x
	
	if position.y<-usedSize.y:
		position.y=1080+usedSize.y
	elif position.y>1080+usedSize.y:
		position.y=-usedSize.y

func playAnimation(selection):
	$AnimatedSprite.animation=selection
	$AnimatedSprite.play()
