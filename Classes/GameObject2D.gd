extends Area2D

onready var sprite = $Sprite
onready var level = get_owner()

func _on_VisibilityNotifier2D_screen_exited():
	pass

func _on_MailBox_body_entered(body):
	pass
