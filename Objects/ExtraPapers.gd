extends Area2D
onready var PaperBoy = Utils.get_by_name("PaperBoy")


func _on_ExtraPapers_area_entered(area):
	print (str(PaperBoy))
	PaperBoy.HASEVERPICKEDUPPAPERS = true
	#SoundFX.play("sound_pickedupmorepapers")
	queue_free()
