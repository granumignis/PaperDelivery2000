extends Control

var selectedMenuItem = 0
var minMenuItem = 0
var maxMenuItem = 1
onready var selecter_StartGame = $MenuSelecter_StartGame
onready var selecter_HowToPlay = $MenuSelecter_HowToPlay
onready var selecter_Exit = $MenuSelecter_Exit

func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)



func _ready():
	VisualServer.set_default_clear_color(Color.black);
	highlightMenuItem(selectedMenuItem)
	yield(get_tree().create_timer(2.8), "timeout")
	
	match int(rand_range(1,3)):
		1:
			SoundFX.play("announcer-paperdelivery2000_version1", 1)
		2:
			SoundFX.play("announcer-paperdelivery2000_version2", 1)
		3:
			SoundFX.play("announcer-paperdelivery2000_version3", 1)


func _on_StartGameButton_pressed():
	#get_tree().change_scene("res://Level00.tscn")
	pass


func _on_ExitButton_pressed():
	#get_tree().quit()
	pass


func PlayMenuItemChangeSound():
	match int(rand_range(1,4)):
		1:
			SoundFX.play("menubeep_version1", 1)
			print("random 1")
		2:
			SoundFX.play("menublip_version2", 1)
			print("random 2")
		3:
			SoundFX.play("menublip_version", 1)
			print("random 3")
		4:
			SoundFX.play("menubloop_bersion1", 1)
			print("random 4")


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if selectedMenuItem != minMenuItem:
			selectedMenuItem -= 1 
			print(str(selectedMenuItem))
			highlightMenuItem(selectedMenuItem)
			PlayMenuItemChangeSound()
					
	if Input.is_action_just_pressed("ui_down"):
		if selectedMenuItem != maxMenuItem:
			selectedMenuItem += 1 
			print(str(selectedMenuItem))
			highlightMenuItem(selectedMenuItem)
			PlayMenuItemChangeSound()
			
	if Input.is_action_just_pressed("Menu_ChooseOption"):
		print("Menu_ChooseOption button was just pressed!")
		SoundFX.play("buleep_version1", 1);
		if selectedMenuItem == 0:
			yield(get_tree().create_timer(.1), "timeout")
			get_tree().change_scene("res://Level00_Luke.tscn")
		if selectedMenuItem == 1:
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
			selecter_HowToPlay.visible = false
			selecter_Exit.visible = true
			
