extends Node

onready var main = get_tree()
onready var Marquee = $Marquee
onready var PaperBoy = $PaperBoy
onready var JumboTron = $JumboTron
onready var MailBox = $MailBox
onready var distance
var firstPlay = true
onready var score = 0

export (int) onready var delivered = 0 setget set_delivered, get_delivered

# Called when the node enters the scene tree for the first time.
func _ready():
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
	# JumboTron.setJumboTronMessage("PAPERS LEFT: " + str(papers_left))
	pass
	
func addToScore(amountToAdd):
	score = score + amountToAdd
	print("New Score: " + str(score))
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
