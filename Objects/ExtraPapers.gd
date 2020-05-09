extends Area2D


func _on_ExtraPapers_area_entered(area):
	queue_free()
