extends Area2D

var minimap_icon = "box"

export(bool) var isFlipped
export(bool) var HasNewsPaperInIt = false
onready var sprite = $Sprite_HD
onready var level = get_owner()

onready var flippedSprite = load("res://Art/Game-Resolution/flipped-newspaper-box.png")

signal NewsPaper_Delivered

	
func _ready():
	print(sprite.texture)
	if (isFlipped):
		print("isflipped!")
		sprite.set_texture(flippedSprite)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	pass

func _on_MailBox_body_entered(body):
	if body.get_class() == "NewsPaper":
		body.queue_free()
		if HasNewsPaperInIt == false:
			print(body.get_class() + " Entered Mailbox")
			level._on_MailBox_NewsPaper_Delivered(self.name, self.position)
			var main = get_tree().current_scene		
			main.delivered = main.delivered +1
			HasNewsPaperInIt = true
			sprite.set_self_modulate(Color( 0, 0.39, 0, 1 ))
			emit_signal("removed", self)

