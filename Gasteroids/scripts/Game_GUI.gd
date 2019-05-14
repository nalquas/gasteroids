extends Control

var pressedThrust = false
var pressedLeft = false
var pressedRight = false
var pressedShoot = false

func _ready():
	#If on mobile, show touch overlay (buttons):
	var name = OS.get_name()
	if name=="Android" or name=="iOS" or name=="UWP":
		setTouchOverlay(true)
	else:
		setTouchOverlay(false)

func setGameOver(gameover):
	$GameOver.visible = gameover

func setScore(score):
	$Score.text = "Score: "+String(score)

func setRespawns(respawns):
	$Respawns.margin_right=131*respawns
	$Respawns.rect_size=Vector2(131*respawns,131)

func setTouchOverlay(show):
	$Thrust.visible = show
	$Thrust.disabled = !show
	$Shoot.visible = show
	$Shoot.disabled = !show
	$Left.visible = show
	$Left.disabled = !show
	$Right.visible = show
	$Right.disabled = !show

func _on_Thrust_button_down():
	pressedThrust = true

func _on_Thrust_button_up():
	pressedThrust = false

func _on_Shoot_button_down():
	pressedShoot = true

func _on_Shoot_button_up():
	pressedShoot = false

func _on_Left_button_down():
	pressedLeft = true

func _on_Left_button_up():
	pressedLeft = false

func _on_Right_button_down():
	pressedRight = true

func _on_Right_button_up():
	pressedRight = false
