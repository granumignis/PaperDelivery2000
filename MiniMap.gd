extends MarginContainer

export (NodePath) var player
export var zoom = 1.0 setget set_zoom

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/playermarker
onready var box_marker = $MarginContainer/Grid/boxmarker

onready var icons = { "box" : box_marker }

var grid_scale
var markers = {}

func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	print("grid.rect_size: " + str(grid.rect_size))
	print("grid_scale: " + str(grid_scale))
	
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		print(item.get_name())
		print(item.minimap_icon)
		var new_marker = icons[item.minimap_icon].duplicate()
		print(icons[item.minimap_icon].get_name())
		grid.add_child(new_marker)
		new_marker.show()
		print(new_marker.name + " " + str(new_marker.global_position)) 
		markers[item] = new_marker

func _process(delta):
	if !player:
		return
	
	player_marker.rotation = get_node(player).rotation + PI/2
	
	for item in markers:
		var obj_pos = (item.position - get_node(player).position) * grid_scale * grid.rect_size / 2
		
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			pass
			# markers[item].scale = Vector2(0.50, 0.50)
		else:
			markers[item].scale = Vector2(1, 1)
		
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)		
		
		markers[item].position = obj_pos
		# print("processpos: " + item.name + " " + str(item.global_position)) 
		
		
func _on_object_removed(object):
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)

func set_zoom(value):
	zoom = clamp(value, 0.5, 5)
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
