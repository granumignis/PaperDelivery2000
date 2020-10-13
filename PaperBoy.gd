extends Node2D

const Newspaper = preload("res://Objects/NewsPaper.tscn")
signal out_of_newspapers
signal shot_newspaper(papers_left)


var moving = false
export(int) var SPEED = 157
export(int) var THROW_SPEED = 157
export(int) var AMMO = 0
export (bool) var CANSHOOT = true

onready var sprite = $Sprite
onready var aim_visual = $"Sprite/aim-visual"
onready var throwpoint = $"Sprite/throwpoint"
onready var extrapapersobjects
onready var paperdisplay = get_tree().get_nodes_in_group("numpaperdisplay")

func _ready():
	sprite.set_self_modulate(Color( 1, 1, 1, 0 ))
	set_process(false)

func _process(delta):
	moving = false
	if Input.is_action_pressed("ui_right"):
		# move(SPEED, 0, delta)
		sprite.flip_h = false
		throwpoint.set_position(Vector2(2,-2))
	if Input.is_action_pressed("ui_left"):
		# move(-SPEED, 0, delta)
		sprite.flip_h = true
		throwpoint.set_position(Vector2(-2,-2))
	if Input.is_action_pressed("ui_up"):
		# move(0, -SPEED, delta)
		pass
	if Input.is_action_pressed("ui_down"):
		# move(0, SPEED, delta)
		pass
	if Input.is_action_just_pressed("ui_accept"):
		throw_newspaper()

func throw_newspaper():
	if (CANSHOOT):
		if AMMO >= 1:
			var newspaper = Utils.instance_scene_on_main(Newspaper, throwpoint.global_position)
			newspaper.velocity = Vector2.RIGHT.rotated(aim_visual.rotation) * THROW_SPEED
			newspaper.velocity.x *= sprite.scale.x
			newspaper.rotation = newspaper.velocity.angle()
			AMMO = AMMO - 1
			updatePaperDisplay()
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

func _on_PaperBoy_area_entered(area):
	print("Area " + str(area) + " : " + area.name + " entered")
	var extrapapersobjects = get_tree().get_nodes_in_group("extrapapers")
	for item in extrapapersobjects:
		if str(area) == str(item):
			AMMO += 5
			updatePaperDisplay()
			print("You picked up 5 extra papers!")
	var collisionobjects = get_tree().get_nodes_in_group("collision")
	for item in collisionobjects:
		if str(area) == str(item):
			AMMO += 5
			updatePaperDisplay()
			print("You contacted a collisionobject!")
			
func updatePaperDisplay():
	for item in paperdisplay:
		item.text = str(AMMO)
