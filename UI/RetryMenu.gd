extends ColorRect

var selectedMenuItem = 0
var minMenuItem = 0
var maxMenuItem = 1

onready var selecter_MainMenu = $Panel/MenuSelecter_MainMenu
onready var selecter_Retry = $Panel/MenuSelecter_Retry
onready var selecter_ResumeGame = $Panel/MenuSelecter_ResumeGame

var paused = false setget set_paused

func _ready():
	highlightMenuItem(selectedMenuItem)

func set_paused(value):
	paused = value
	get_tree().paused = paused
	visible = paused
	
func _process(delta):		
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
				_on_RetryButton_pressed()
			if selectedMenuItem == 1:
				_on_MainMenuButton_pressed()

func _on_ResumeButton_pressed():
	self.paused = false

func _on_RetryButton_pressed():
	print("retrybuttonpressed")
	self.paused = false
	get_tree().reload_current_scene()

func _on_MainMenuButton_pressed():
	self.paused = false
	get_tree().change_scene("res://UI/MainMenu.tscn")


func highlightMenuItem(selectedMenuItem):
	match selectedMenuItem:
		0:
			selecter_Retry.visible = true
			selecter_MainMenu.visible = false
		1:
			selecter_Retry.visible = false
			selecter_MainMenu.visible = true



