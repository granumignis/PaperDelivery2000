extends Node2D

const Newspaper = preload("res://Objects/NewsPaper.tscn")
signal out_of_newspapers
signal shot_newspaper(papers_left)

var moving = false
export(int) var SPEED = 157
export(int) var THROW_SPEED = 157
export(int) var AMMO = 6
export (bool) var CANSHOOT = true

onready var sprite = $Sprite
onready var aim_visual = $"Sprite/aim-visual"

func _ready():
	sprite.set_self_modulate(Color( 1, 1, 1, 0 ))
	set_process(false)
	
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
	if (CANSHOOT):
		if AMMO >= 1:
			var newspaper = Utils.instance_scene_on_main(Newspaper, aim_visual.global_position)
			newspaper.velocity = Vector2.RIGHT.rotated(aim_visual.rotation) * THROW_SPEED
			newspaper.velocity.x *= sprite.scale.x
			newspaper.rotation = newspaper.velocity.angle()
			AMMO = AMMO - 1
			print("CURRENT AMMO: "+ str(AMMO))
			emit_signal("shot_newspaper", AMMO)
		else:
			print("OUT OF NEWSPAPERS")
			emit_signal("out_of_newspapers")

func move(xspeed, yspeed, delta):
	position.x += xspeed * delta
	position.y += yspeed * delta
	moving = true

func set_canshoot(value):
	CANSHOOT = value

func set_showReticle(value):
	aim_visual.setVisibility(false)
