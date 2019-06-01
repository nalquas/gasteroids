extends "FlyingObject.gd"

export (int) var shotSpeed
export (int) var shotTimeMsec

var tSpawn = OS.get_system_time_msecs()

func _ready():
	#Grouping
	add_to_group("shots")
	
	#Changes to FlyingObject variables specific to Shot
	objectSize=Vector2(24,24)
	setDirection(35)
	tSpawn=OS.get_system_time_msecs()
	running = true
	$ShotAudio.play()

#warning-ignore:unused_argument
func _process(delta):
	#Kill shot after 1500ms
	if OS.get_system_time_msecs()-tSpawn>shotTimeMsec:
		kill()

func kill():
	running = false
	queue_free()

func setDirection(direction):
	rotation_degrees=-direction
	setSpeedByDirection(deg2rad(direction),shotSpeed)