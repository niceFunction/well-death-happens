extends State

# Maximum speed that the Character can reach, X is horizontal max speed, Y can be referred to "maximum fall speed".
export var max_speed_default: = Vector2(300.0, 1500.0)
# A very high value is used on X axis to instantly reach the previous values. 
# Y axis can be considered as "gravity".
var acceleration_default: = Vector2(5000.0, 1500.0)
export var jump_impulse: = 450.0 # Force of the jump.

# "Basic" variables for movement.
var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO # Used for the "move_and_slide()" method

# Applies different more/less "gravity" going up or down while jumping.
export(float, -0.5, 2.0) var up_gravity: = 1.02 # Applies less gravity going up.
export(float, -0.5, 2.0) var down_gravity: = 1.04 # Applies more gravity going down.

# Jumps become shorter depending on how long the Player holds down the "Jump" button.
var jump_cutoff: = false # Used in the "Air" state script.

# Makes the Charadcter "jump" & changes the state to "Air".
func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("Jump"):
		_state_machine.transition_to("Move/Air", {impulse = jump_impulse})

func physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("Jump") and velocity.y < 0.0

	velocity = calculate_velocity(
		velocity, 
		max_speed, 
		acceleration,
		is_jump_interrupted, 
		delta, 
		get_move_direction())
	
	# Applies different "gravities".
	apply_gravity()
	
	# Moves the Character.
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)

func enter(message: Dictionary = {}) -> void:
	$Air.connect("jumped", $Idle.jump_buffer, "start")

func exit(message: Dictionary = {}) -> void:
	$Air.disconnect("jumped", $Idle.jump_buffer, "start")

static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		is_jump_interrupted: bool,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity: = old_velocity
	
	# Calculate based on the Player's current direction.
	new_velocity += move_direction * acceleration * delta
	# Clamp the velocity along the X/Y axises.
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	
	if is_jump_interrupted:
		new_velocity.y = 0.0
	
	return new_velocity

# Moves the Character to the Left & Right.
static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft"),
		1.0
	)

func apply_gravity() -> void:
	# Applies a lower "gravity" when jumping up
	if velocity.y < 0:
		velocity.y *= up_gravity
	# Applies a higher "gravity" when falling down
	elif velocity.y > 0:
		velocity.y *= down_gravity
	# Sets the velocity.y (or "gravity") to "normal".
	elif owner.is_on_floor():
		velocity.y = 0.0
