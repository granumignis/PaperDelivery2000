extends Node



func instance_scene_on_main(scene, position):
	var instance = scene.instance()
	var main = get_tree().current_scene
	main.add_child(instance)
	instance.global_position = position
	return instance
