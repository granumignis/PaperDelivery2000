extends MarginContainer

onready var player = Utils.get_by_name("PaperBoyPhyz")
export var zoom = 1.5 setget set_zoom

onready var grid = Utils.get_by_name("Grid")
onready var player_marker = Utils.get_by_name("playermarker")
onready var box_marker = Utils.get_by_name("boxmarker")

onready var icons = { "box" : box_marker }

var grid_scale
var markers = {}

func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker

func _process(delta):
	if !player:
		return
	
	player_marker.rotation = player.rotation + PI/2
	
	for item in markers:
		var obj_pos = (item.position - player.position) * grid_scale + grid.rect_size / 2
		
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			markers[item].scale = Vector2(1, 1)
		else:
			markers[item].scale = Vector2(1, 1)
		
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)		
		
		markers[item].position = obj_pos
		
		
func _on_object_removed(object):
	print("_on_object_removed: " + str(object))
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)

func set_zoom(value):
	zoom = clamp(value, 0.5, 5)
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)


func _on_MailBox_removed(object):
	print("_on_object_removed: " + str(object.get_name()))
	if object in markers:
		markers[object].queue_free()
		markers.erase(object)
