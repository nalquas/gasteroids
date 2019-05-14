extends Control

signal start
signal fullscreen

func _ready():
	#Signals
	# warning-ignore:return_value_discarded
	connect("start", get_parent(), "_on_Main_Menu_start")
	# warning-ignore:return_value_discarded
	connect("fullscreen", get_parent(), "_on_Main_Menu_fullscreen")

func _on_Start_pressed():
	emit_signal("start")

func setVisible(visibility):
	visible = visibility
	$Start.disabled = !visibility

func _on_Fullscreen_pressed():
	emit_signal("fullscreen")

func _on_Exit_pressed():
	get_tree().quit()
