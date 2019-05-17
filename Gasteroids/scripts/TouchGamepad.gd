extends Node2D

var pressedThrust = false
var pressedShoot = false
var pressedLeft = false
var pressedRight = false

func _ready():
	pass

func _on_Thrust_pressed():
	pressedThrust = true

func _on_Thrust_released():
	pressedThrust = false

func _on_Shoot_pressed():
	pressedShoot = true

func _on_Shoot_released():
	pressedShoot = false

func _on_Left_pressed():
	pressedLeft = true

func _on_Left_released():
	pressedLeft = false

func _on_Right_pressed():
	pressedRight = true

func _on_Right_released():
	pressedRight = false
