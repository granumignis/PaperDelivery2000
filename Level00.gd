extends Node

onready var Marquee = $Marquee
onready var PaperBoy = $PaperBoy
onready var JumboTron = $JumboTron

export (int) onready var delivered = 0 setget set_delivered, get_delivered

# Called when the node enters the scene tree for the first time.
func _ready():
	JumboTron.setJumboTronMessage("Game Start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_delivered(value):
	delivered = value
	JumboTron.setJumboTronMessage(str(delivered) + " Papers Delivered")
	if delivered >= 6:
		JumboTron.setJumboTronMessage("GAME OVER")


func get_delivered():
	return delivered

func _on_MailBox_NewsPaper_Delivered():
	self.set_delivered(1)
	print(delivered)
