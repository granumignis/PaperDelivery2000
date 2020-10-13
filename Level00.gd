extends Node

onready var main = get_tree()
onready var Marquee = $Marquee
onready var PaperBoy = $PaperBoy/PaperBoy
onready var PaperBoyPhyz = $PaperBoy
onready var JumboTron = $JumboTronCanvas/JumboTron
onready var MailBox = $MailBox
onready var distance
onready var scoreMultiplier
onready var numberOfMailBoxes = 0
onready var numberOfExtraPaperBundles = 0
onready var paperdisplay = get_tree().get_nodes_in_group("numpaperdisplay")
onready var maincam = $Camera

var time_of_last_delivery = 10000

var firstPlay = true
onready var score = 0

export (int) onready var delivered = 0 setget set_delivered, get_delivered


func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _proces():
	maincam.position.x = PaperBoyPhyz.position.x
	
# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color.black)
	display_high_score()
	PaperBoy.set_process(true)
	updatePaperDisplay()
	
	for object in get_tree().get_nodes_in_group("minimap_objects"):
		print("listing minimap_objects: " + str(object.get_name()))
		# object.connect("removed", $UI/MiniMap, "on_object_removed") 
		numberOfMailBoxes += 1
		print("numberOfMailBoxes: " + str(numberOfMailBoxes))
		
	yield(get_tree().create_timer(3), "timeout")
	JumboTron.setJumboTronMessage("SCORE: " + str(score))
	
	
func set_delivered(value):
	delivered = value
	time_of_last_delivery = OS.get_unix_time()
	wait(3)
	if delivered >= numberOfMailBoxes:
		PaperBoy.set_canshoot(false)
		JumboTron.setJumboTronMessage("WIN")
		PaperBoy.set_showReticle(false)
		yield(get_tree().create_timer(3), "timeout")
		update_score_data()
		check_for_new_high_score()
		yield(get_tree().create_timer(3), "timeout")
		get_tree().change_scene("res://UI/MainMenu.tscn")

func get_delivered():
	return delivered

func _on_MailBox_NewsPaper_Delivered(mailboxName, mailboxPosition):
	distance = mailboxPosition.distance_to(PaperBoy.global_position); 
	print("distance to " + str(mailboxName) + ": " + str(distance))
	addToScore(int(round(distance * 100)))

func _on_PaperBoy_out_of_newspapers():
	notify_out_of_papers()
	for object in get_tree().get_nodes_in_group("extrapapers"):
		numberOfExtraPaperBundles += 1
	print("numberofExtraPaperBundles: " + str(numberOfExtraPaperBundles))
	if numberOfExtraPaperBundles == 0:
		PaperBoy.set_canshoot(false)
		JumboTron.setJumboTronMessage("OUT OF PAPERS. \n OUT OF BUNDLES. \n GAME OVER.")
		yield(get_tree().create_timer(3), "timeout")
		JumboTron.setJumboTronMessage("OUT OF PAPERS. \n OUT OF BUNDLES. \n GAME OVER.")
	
	numberOfExtraPaperBundles = 0	
		
func notify_out_of_papers():
	JumboTron.setJumboTronMessage("OUT OF PAPERS")
	yield(get_tree().create_timer(3), "timeout")
	JumboTron.setJumboTronMessage("SCORE: " + str(score))
	

func restart_game():
	delivered = 0
	
func _on_PaperBoy_shot_newspaper(papers_left):
	var tmpDelivered =  delivered
	print ("papers_left: " + str(papers_left) + " " + "tmpDelivered" + " " + str(tmpDelivered))
	
func addToScore(amountToAdd):
	if (OS.get_unix_time() - time_of_last_delivery <= 1):
		scoreMultiplier = 2
		score = score + (amountToAdd * scoreMultiplier)
	else:
		scoreMultiplier = 1
		score = score + (amountToAdd)
		
		
	print("New Score: " + str(score) + " (X" + str(scoreMultiplier) + " BONUS!)")
	JumboTron.setJumboTronMessage("SCORE: " + str(score))
		
func display_high_score():
	var score_data = SaveAndLoad.load_score_from_file()
	JumboTron.setJumboTronMessage("HIGH SCORE: " + str(score_data.highscore))

func update_score_data():
	var score_data = SaveAndLoad.load_score_from_file()
	if score > score_data.highscore:
		score_data.highscore = score
		SaveAndLoad.save_score_to_file(score_data)

func check_for_new_high_score():
	var score_data = SaveAndLoad.load_score_from_file()
	if score > score_data.highscore:
		JumboTron.setJumboTronMessage("New High Score!" + str(score))
	else:
		JumboTron.setJumboTronMessage("Score: " + str(score))

func wait(delaySeconds):
	yield(get_tree().create_timer(delaySeconds), "timeout")


func _on_MiniMap_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			self.zoom += 0.1
		if event.button_index == BUTTON_WHEEL_DOWN:
			self.zoom -= 0.1

func updatePaperDisplay():
	for item in paperdisplay:
		item.text = str(PaperBoy.AMMO)
