extends Node

export (PackedScene) var scene_game
#export (PackedScene) var scene_menu

var highscore = 0

func save(content):
	var file = File.new()
	file.open("user://highscore.dat", file.WRITE)
	file.store_string(String(content))
	file.close()

func load_save():
	var file = File.new()
	file.open("user://highscore.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _ready():
	$Main_Menu.setVisible(true)
	
	#Show highscore
	if not File.new().file_exists("user://highscore.dat"):
		save(String(0))
	highscore=int(load_save())
	$Main_Menu.setHighscore(highscore)

#warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggleFullscreen()

func toggleFullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_Game_gameover(score):
	if score>highscore:
		highscore=score
		save(score)
		$Main_Menu.setHighscore(highscore)
		$Main_Menu/Highscore.text+=" (NEW!)"
	
	$Game.call_deferred("queue_free")
	$Main_Menu.setVisible(true)

func _on_Main_Menu_start():
	$Main_Menu.setVisible(false)
	var newGame = scene_game.instance()
	call_deferred("add_child", newGame)

func _on_Main_Menu_fullscreen():
	toggleFullscreen()
