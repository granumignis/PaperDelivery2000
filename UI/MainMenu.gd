extends Control

var selectedMenuItem = 0
var minMenuItem = 0
var maxMenuItem = 2
onready var selecter_StartGame = $MenuSelecter_StartGame
onready var selecter_HowToPlay = $MenuSelecter_HowToPlay
onready var selecter_Exit = $MenuSelecter_Exit

func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)



func _ready():
	VisualServer.set_default_clear_color(Color.black);
	highlightMenuItem(selectedMenuItem)


func _on_StartGameButton_pressed():
	pass
	# get_tree().change_scene("res://Level00.tscn")

func _on_ExitButton_pressed():
	pass
	# get_tree().quit()


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if selectedMenuItem != minMenuItem:
			selectedMenuItem -= 1 
			print(str(selectedMenuItem))
			highlightMenuItem(selectedMenuItem)
	if Input.is_action_just_pressed("ui_down"):
		if selectedMenuItem != maxMenuItem:
			selectedMenuItem += 1 
			print(str(selectedMenuItem))
			highlightMenuItem(selectedMenuItem)
	if Input.is_action_just_pressed("Menu_ChooseOption"):
		if selectedMenuItem == 0:
			yield(get_tree().create_timer(.1), "timeout")
			get_tree().change_scene("res://Level00_simplify.tscn")
		if selectedMenuItem == 1:
			pass
		if selectedMenuItem == 2:
			yield(get_tree().create_timer(1), "timeout")
			get_tree().quit()

func highlightMenuItem(selectedMenuItem):
	match selectedMenuItem:
		0:
			selecter_StartGame.visible = true
			selecter_HowToPlay.visible = false
			selecter_Exit.visible = false
		1:
			selecter_StartGame.visible = false
			selecter_HowToPlay.visible = true
			selecter_Exit.visible = false
		2: 
			selecter_StartGame.visible = false
			selecter_HowToPlay.visible = false
			selecter_Exit.visible = true
			
