extends Node

signal gameover

export (PackedScene) var scene_asteroid
export (PackedScene) var scene_shot

var level = 0
var score = 0
var respawns = 2
var waitingForNextLevel = false
var t_nextLevel = 0
var waitingForRespawn = false
var t_respawn = 0
var waitingForGameover = false
var t_gameover = 0

func _ready():
	#Signals
	# warning-ignore:return_value_discarded
	connect("gameover", get_parent(), "_on_Game_gameover")
	
	$Game_GUI.setScore(score)
	$Game_GUI.setRespawns(respawns)
	$Game_GUI.setGameOver(false)
	spawnAsteroids(5+level*2)

#warning-ignore:unused_argument
func _process(delta):
	#Respawn handling
	if waitingForRespawn and OS.get_system_time_msecs()-t_respawn>3000:
		waitingForRespawn = false
		$Ship.position = Vector2(rand_range(0,1920),rand_range(0,1080))
		$Ship.speed = Vector2(0,0)
		$Ship.setActive(true)
		$Ship.setImmune(true)
	
	#Levelup handling
	if waitingForNextLevel:
		if OS.get_system_time_msecs()-t_nextLevel>1500: #Levelup
			waitingForNextLevel = false
			level+=1
			spawnAsteroids(5+level*2)
	elif get_tree().get_nodes_in_group("asteroids").size()==0: #Trigger levelup timers
		nextLevel()
	
	#Gameover handling
	if waitingForGameover and OS.get_system_time_msecs()-t_gameover>3000:
		waitingForGameover = false
		emit_signal("gameover")

func nextLevel():
	waitingForNextLevel = true
	t_nextLevel = OS.get_system_time_msecs()

func spawnAsteroids(count):
	spawnAsteroidsControlled(count,Vector2(0,0),3,false)

func spawnAsteroidsControlled(count,positionVector,asteroidSize,forceSettings):
	randomize()
	#warning-ignore:unused_variable
	for i in range(0,count):
		var newAsteroid = scene_asteroid.instance()
		if forceSettings:
			newAsteroid.position=positionVector
			newAsteroid.setSize(asteroidSize)
		else:
			var forcedRun = true
			while forcedRun or (newAsteroid.position-$Ship.position).length()<512:
				forcedRun = false
				newAsteroid.position=Vector2(rand_range(0,1920),rand_range(0,1080))
			newAsteroid.setSize(int(rand_range(0,4)))
		call_deferred("add_child", newAsteroid)

func _on_Ship_shoot():
	#Create a new shot
	var newShot = scene_shot.instance()
	add_child(newShot)
	
	#Make the shot travel into direction ship is facing
	newShot.position=$Ship.position
	newShot.setDirection(180-$Ship.rotation_degrees)

func _on_Asteroid_hit_ship():
	if $Ship.running:
		score-=1
		$Ship.setActive(false)
		if respawns>0:
			respawns-=1
			$Game_GUI.setRespawns(respawns)
			waitingForRespawn = true
			t_respawn = OS.get_system_time_msecs()
		else:
			#Trigger game over
			$Game_GUI.setGameOver(true)
			for shot in get_tree().get_nodes_in_group("shots"):
				shot.kill()
			waitingForGameover = true
			t_gameover = OS.get_system_time_msecs()

func _on_Asteroid_split(asteroid):
	spawnAsteroidsControlled(2,asteroid.position,asteroid.asteroidSize-1,true)

func _on_Asteroid_destroyed():
	score+=1
	$Game_GUI.setScore(score)
