extends Area2D

onready var Sprite = $Sprite
onready var AnimationPlayer = $HouseAnimationPlayer

var fadeout = 0
var fadein = 0

var fullbright = Color(1,1,1,1)
var halfalpha = Color(1,1,1,.5)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_House3_area_entered(area):	
	print(area.name + " just intersected a house sprite")
	print(str(area.z_index) + " <-- z index of thing that intersected")
	print(str(self.z_index) + "<-- z index of house that got intersected.")
	if area.name in ("DigitalMan"):
		AnimationPlayer.play("FadeOut")
		#fadeout = 1
		#Sprite.modulate = Color(1,1,1,.5)


func _on_House3_area_exited(area):
	print(area.name + " just intersected a house sprite")
	if area.name in ("DigitalMan"):
		AnimationPlayer.play_backwards("FadeOut")
		#Sprite.modulate = Color(1,1,1,1)
