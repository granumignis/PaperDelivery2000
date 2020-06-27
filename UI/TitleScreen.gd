extends Control


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://UI/MainMenu.tscn")
	print("Processing")
