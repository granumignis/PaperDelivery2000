extends Node2D

var velocity = Vector2.ZERO

func _process(delta):
	position += velocity * delta
	rotation_degrees += 5.5

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func get_class(): return "NewsPaper"



