extends Node2D

var touchActive = false
var pressedThrust = false
var pressedShoot = false
var pressedLeft = false
var pressedRight = false

func _ready():
	#If on mobile, show touch overlay (buttons):
	var name = OS.get_name()
	if name=="Android" or name=="iOS" or name=="UWP":
		setTouchOverlay(true)
	else:
		setTouchOverlay(false)

func setTouchOverlay(show):
	touchActive = show

func _on_Thrust_pressed():
	if touchActive:
		pressedThrust = true

func _on_Thrust_released():
	if touchActive:
		pressedThrust = false

func _on_Shoot_pressed():
	if touchActive:
		pressedShoot = true

func _on_Shoot_released():
	if touchActive:
		pressedShoot = false

func _on_Left_pressed():
	if touchActive:
		pressedLeft = true

func _on_Left_released():
	if touchActive:
		pressedLeft = false

func _on_Right_pressed():
	if touchActive:
		pressedRight = true

func _on_Right_released():
	if touchActive:
		pressedRight = false
