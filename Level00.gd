extends Node

onready var Marquee = $Marquee
onready var PaperBoy = $PaperBoy
onready var JumboTron = $JumboTron
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
	if delivered >= 6:
		JumboTron.setJumboTronMessage("WIN")
		PaperBoy.queue_free()


func get_delivered():
	return delivered

func _on_MailBox_NewsPaper_Delivered():
	self.set_delivered(1)
	print(delivered)


func _on_PaperBoy_out_of_newspapers():
	PaperBoy.queue_free()
	JumboTron.setJumboTronMessage("GAME OVER")
	yield(get_tree().create_timer(5.0), "timeout")
	JumboTron.setJumboTronMessage("TRY AGAIN")
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().change_scene("res://Level00.tscn")

func restart_game():
	delivered = 0
	
	
