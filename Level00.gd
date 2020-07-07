extends Node

onready var main = get_tree()
onready var Marquee = $Marquee
onready var PaperBoy = $PaperBoy
onready var JumboTron = $UI/JumboTron
onready var MailBox = $MailBox
onready var distance
onready var scoreMultiplier

var time_of_last_delivery = 10000

var firstPlay = true
onready var score = 0

export (int) onready var delivered = 0 setget set_delivered, get_delivered

func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color.black)
	display_high_score()
	yield(get_tree().create_timer(3), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 3")
	yield(get_tree().create_timer(1), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 2")
	yield(get_tree().create_timer(1), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 1")
	yield(get_tree().create_timer(1), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 0")
	PaperBoy.set_process(true)
	yield(get_tree().create_timer(1), "timeout")
	JumboTron.setJumboTronMessage("SCORE: " + str(score))

func set_delivered(value):
	delivered = value
	time_of_last_delivery = OS.get_unix_time()
	wait(3)
	if delivered >= 6:
		PaperBoy.set_canshoot(false)
		JumboTron.setJumboTronMessage("WIN")
		PaperBoy.set_showReticle(false)
		yield(get_tree().create_timer(3), "timeout")
		update_score_data()
		check_for_new_high_score()
		yield(get_tree().create_timer(3), "timeout")
		JumboTron.setJumboTronMessage("PLAY AGAIN!")
		yield(get_tree().create_timer(6), "timeout")
		get_tree().change_scene("res://Level00.tscn")

func get_delivered():
	return delivered

func _on_MailBox_NewsPaper_Delivered(mailboxName, mailboxPosition):
	distance = mailboxPosition.distance_to(PaperBoy.global_position); 
	print("distance to " + str(mailboxName) + ": " + str(distance))
	addToScore(int(round(distance * 100)))

func _on_PaperBoy_out_of_newspapers():
	PaperBoy.queue_free()
	JumboTron.setJumboTronMessage("OUT OF PAPERS")
	yield(get_tree().create_timer(5), "timeout")
	JumboTron.setJumboTronMessage("TRY AGAIN")
	update_score_data()
	check_for_new_high_score()
	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Level00.tscn")

func restart_game():
	delivered = 0
	
func _on_PaperBoy_shot_newspaper(papers_left):
	var tmpDelivered =  delivered
	print ("papers_left: " + str(papers_left) + " " + "tmpDelivered" + " " + str(tmpDelivered))
	yield(get_tree().create_timer(5), "timeout")
	if delivered == tmpDelivered:
		PaperBoy.CANSHOOT = false
		print("You did not deliver the last thrown paper within 5 seconds")
		update_score_data()
		JumboTron.setJumboTronMessage("MISSED A MAILBOX")
		yield(get_tree().create_timer(3), "timeout")
		JumboTron.setJumboTronMessage("AND DIDN'T DELIVER")
		yield(get_tree().create_timer(3), "timeout")		
		JumboTron.setJumboTronMessage("ANOTHER IN < 5 SECS")
		yield(get_tree().create_timer(3), "timeout")		
		JumboTron.setJumboTronMessage("GAME OVER")
		yield(get_tree().create_timer(4), "timeout")
		get_tree().change_scene("res://UI/MainMenu.tscn")
	
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
