extends Area2D

export(int) var WALKSPEED = 50
export(int) var RUNSPEED = 100
var SPEED = WALKSPEED
export(bool) var hasCrouched = false

var moving = false
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var CrouchSprite = $CrouchSprite
onready var WalkCrouchedSprite = $WalkCrouchedSprite
onready var animationIndex = "idle"

func _process(delta):
	moving = false
	if Input.is_action_pressed("ui_right"):
		move(SPEED, 0, delta)
		sprite.flip_h = false
		CrouchSprite.flip_h = true
		WalkCrouchedSprite.flip_h = true
		animationIndex="right"
	if Input.is_action_pressed("ui_left"):
		move(-SPEED, 0, delta)
		sprite.flip_h = true
		CrouchSprite.flip_h = false
		WalkCrouchedSprite.flip_h = false
		animationIndex="left"
	if Input.is_action_pressed("ui_up"):
		move(0, -SPEED, delta)
		animationIndex="up"
	if Input.is_action_pressed("ui_down"):
		move(0, SPEED, delta)
		animationIndex="down"
		
	if Input.is_action_just_released("ui_right"):
		animationIndex="right"
		if animationPlayer.current_animation == ("WalkingWhileCrouched"):
			hasCrouched = false
			CrouchSprite.visible = false
			sprite.visible = true
			animationPlayer.current_animation = "Run"

	if Input.is_action_just_released("ui_left"):
		animationIndex="left"
		if animationPlayer.current_animation == ("WalkingWhileCrouched"):
			hasCrouched = false
			CrouchSprite.visible = false
			sprite.visible = true
			animationPlayer.current_animation = "Run"


	if Input.is_action_just_released("ui_down"):
		animationIndex="down"


	if Input.is_action_just_released("ui_up"):
		animationIndex="up"
		
	if Input.is_action_pressed("ui_cancel"):
		SPEED = RUNSPEED
	else:
		SPEED = WALKSPEED
		
	if Input.is_action_pressed("ui_accept"):
		pass
			
	if moving == true:
		if hasCrouched == true:
			if animationIndex == "right" or "left":
				animationPlayer.play("WalkingWhileCrouched")
		else:
			match animationIndex:
				"left":
					animationPlayer.play("Run")
				"right":
					animationPlayer.play("Run")
				"up":
					animationPlayer.play("WalkAwayFromCamera")
				"down":
					animationPlayer.play("WalkTowardsCamera")
		
	else:
		if Input.is_action_just_pressed("crouch") && animationPlayer.current_animation != "Crouch":
			if hasCrouched == false:
				animationPlayer.play("Crouch")
				yield(get_tree().create_timer(animationPlayer.current_animation_length), "timeout")
		if Input.is_action_just_pressed("crouch"):
			if hasCrouched == true:
				animationPlayer.play_backwards("Crouch")
				yield(get_tree().create_timer(animationPlayer.current_animation_length), "timeout")
			


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
