extends ColorRect

var selectedMenuItem = 0
var minMenuItem = 0
var maxMenuItem = 1

onready var selecter_MainMenu = $MenuSelecter_MainMenu
onready var selecter_ResumeGame = $MenuSelecter_ResumeGame

var paused = false setget set_paused

func _ready():
	highlightMenuItem(selectedMenuItem)

func set_paused(value):
	paused = value
	get_tree().paused = paused
	visible = paused
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		self.paused = !paused
		
	if (paused):
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
				_on_ResumeButton_pressed()
			if selectedMenuItem == 1:
				_on_MainMenuButton_pressed()	


func _on_ResumeButton_pressed():
	self.paused = false

func _on_MainMenuButton_pressed():
	self.paused = false
	get_tree().change_scene("res://UI/MainMenu.tscn")


func highlightMenuItem(selectedMenuItem):
	match selectedMenuItem:
		0:
			selecter_MainMenu.visible = false
			selecter_ResumeGame.visible = true
		1:
			selecter_MainMenu.visible = true
			selecter_ResumeGame.visible = false


