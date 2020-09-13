extends KinematicBody2D

const WALK_FORCE = 7300
const WALK_MAX_SPEED = 87
const STOP_FORCE = 7300
const JUMP_SPEED = 200

var velocity = Vector2()

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	var xwalk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	# Slow down the player if they're not trying to move.
	if abs(xwalk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += xwalk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	
	

	# Vertical movement code. Apply gravity.
	# velocity.y += gravity * delta
	var ywalk = WALK_FORCE * (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	# Slow down the player if they're not trying to move.
	if abs(ywalk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.y = move_toward(velocity.y, 0, STOP_FORCE * delta)
	else:
		velocity.y += ywalk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.y = clamp(velocity.y, -WALK_MAX_SPEED, WALK_MAX_SPEED)


	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
