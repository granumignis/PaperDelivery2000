extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var JumboTronAnimator = $Animator
onready var JumboTron = $Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setJumboTronMessage(messageToDisplay):
	print("Attempting to set JumboTron Message To: " + messageToDisplay)
	JumboTron.text = messageToDisplay
