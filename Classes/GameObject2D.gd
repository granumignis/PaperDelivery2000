extends Area2D

export(bool) var HasNewsPaperInIt = false
onready var sprite = $Sprite


signal NewsPaper_Delivered

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_MailBox_body_entered(body):
	if body.get_class() == "NewsPaper":
		body.queue_free()
		if HasNewsPaperInIt == false:
			print(body.get_class() + " Entered Mailbox")
			emit_signal("NewsPaper_Delivered")
			var main = get_tree().current_scene		
			main.delivered = main.delivered +1
			HasNewsPaperInIt = true
			sprite.set_self_modulate(Color( 0, 0.39, 0, 1 ))

