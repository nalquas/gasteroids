extends Node

export (PackedScene) var scene_game
#export (PackedScene) var scene_menu

func _ready():
	$Main_Menu.setVisible(true)

#warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggleFullscreen()

func toggleFullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_Game_gameover():
	$Game.call_deferred("queue_free")
	$Main_Menu.setVisible(true)

func _on_Main_Menu_start():
	$Main_Menu.setVisible(false)
	var newGame = scene_game.instance()
	call_deferred("add_child", newGame)

func _on_Main_Menu_fullscreen():
	toggleFullscreen()
