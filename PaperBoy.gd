extends Node2D

const Newspaper = preload("res://Objects/Newspaper.tscn")

var moving = false
export(int) var SPEED = 157
export(int) var THROW_SPEED = 157

onready var sprite = $Sprite
onready var aim_visual = $"Sprite/aim-visual"

func _process(delta):
	moving = false
	if Input.is_action_pressed("ui_right"):
		move(SPEED, 0, delta)
		sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		move(-SPEED, 0, delta)
		sprite.flip_h = true
	if Input.is_action_pressed("ui_up"):
		move(0, -SPEED, delta)
	if Input.is_action_pressed("ui_down"):
		move(0, SPEED, delta)
	if Input.is_action_just_pressed("ui_accept"):
		throw_newspaper()
	
func throw_newspaper():
	var newspaper = Utils.instance_scene_on_main(Newspaper, aim_visual.global_position)
	newspaper.velocity = Vector2.RIGHT.rotated(aim_visual.rotation) * THROW_SPEED
	newspaper.velocity.x *= sprite.scale.x
	newspaper.rotation = newspaper.velocity.angle()

func move(xspeed, yspeed, delta):
	position.x += xspeed * delta
	position.y += yspeed * delta
	moving = true
