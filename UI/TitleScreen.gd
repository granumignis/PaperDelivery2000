extends Control

func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		yield(get_tree().create_timer(.1), "timeout")
		get_tree().change_scene("res://UI/MainMenu.tscn")
	print("Processing")
