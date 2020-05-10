extends Area2D

export(int) var WALKSPEED = 50
export(int) var RUNSPEED = 100
var SPEED = WALKSPEED

var moving = false
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

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
	if Input.is_action_pressed("ui_cancel"):
		SPEED = RUNSPEED
	else:
		SPEED = WALKSPEED
		
	if Input.is_action_pressed("ui_accept"):
		pass
			
	if moving == true:
		animationPlayer.play("Run")
	else:
		animationPlayer.play("Idle")
	pass

func move(xspeed, yspeed, delta):
	#position.x += xspeed * delta
	#position.y += yspeed * delta
	moving = true



func _on_DigitalMan_area_entered(area):
	"""	if area.is_in_group("Interactable"):
		area.interact()
	elif area.is_in_group("PowerUps"):
		area.queue_free()"""
	pass
