extends Node2D

func _process(delta):
	var player = get_parent()
	
	# Mouse based aiming
	rotation = player.get_local_mouse_position().angle()

	# Right-Stick (GamePad) Based Aiming
	# Code below from https://godotengine.org/qa/35254/how-to-aim-right-game-pad-analog-stick
	var deadzone = 0.20
	var controllerangle = Vector2.ZERO
	var xAxisRL = Input.get_joy_axis(0, JOY_AXIS_2)
	var yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_3)
	
	if abs(xAxisRL) > deadzone || abs(yAxisUD) > deadzone:
	    controllerangle = Vector2(xAxisRL, yAxisUD).angle()
	    rotation = controllerangle
