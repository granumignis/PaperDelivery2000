extends Node

onready var main = get_tree()
onready var Marquee = $Marquee
onready var PaperBoy = $PaperBoy
onready var JumboTron = $JumboTron
onready var MailBox = $MailBox
onready var distance
var firstPlay = true


export (int) onready var delivered = 0 setget set_delivered, get_delivered

# Called when the node enters the scene tree for the first time.
func _ready():
	JumboTron.setJumboTronMessage("Game Start: 3")
	yield(get_tree().create_timer(1.0), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 2")
	yield(get_tree().create_timer(1.0), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 1")
	yield(get_tree().create_timer(1.0), "timeout")
	JumboTron.setJumboTronMessage("Game Start: 0")
	PaperBoy.set_process(true)
	yield(get_tree().create_timer(1.0), "timeout")
	JumboTron.setJumboTronMessage("")

func set_delivered(value):
	delivered = value
	JumboTron.setJumboTronMessage(str(delivered) + " Papers Delivered")
	yield(get_tree().create_timer(3.0), "timeout")
	if delivered >= 6:
		PaperBoy.set_canshoot(false)
		JumboTron.setJumboTronMessage("WIN")
		PaperBoy.set_showReticle(false)
		yield(main.create_timer(9.0), "timeout")
		JumboTron.setJumboTronMessage("IT'S OVER")
		yield(main.create_timer(3.0), "timeout")
		main.quit()



func get_delivered():
	return delivered

func _on_MailBox_NewsPaper_Delivered():
	distance = MailBox.global_position.distance_to(PaperBoy.global_position); 
	print("distance to MailBox2: " + str(distance))



func _on_PaperBoy_out_of_newspapers():
	PaperBoy.queue_free()
	JumboTron.setJumboTronMessage("OUT OF PAPERS")
	yield(get_tree().create_timer(5.0), "timeout")
	JumboTron.setJumboTronMessage("TRY AGAIN")
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().change_scene("res://Level00.tscn")

func restart_game():
	delivered = 0
	
	


func _on_PaperBoy_shot_newspaper(papers_left):
	# JumboTron.setJumboTronMessage("PAPERS LEFT: " + str(papers_left))
	pass
	
