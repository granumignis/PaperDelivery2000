extends Control

func _ready():
	VisualServer.set_default_clear_color(Color.black);


func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Level00.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
