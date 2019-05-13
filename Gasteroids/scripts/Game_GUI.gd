extends Control

func _ready():
	pass

func setGameOver(gameover):
	$GameOver.visible = gameover

func setScore(score):
	$Score.text = "Score: "+String(score)

func setRespawns(respawns):
	$Respawns.margin_right=131*respawns
	$Respawns.rect_size=Vector2(131*respawns,131)