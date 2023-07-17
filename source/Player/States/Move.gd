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

# Gravity
var gravity: = 5.0 # Base "gravity".
export var fall_gravity_multiplier: = 4.0 # Applies MORE gravity when you fall.
export var up_gravity_multiplier: = 1.5 # Applies LESS gravity when you jump.

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
		acceleration, # We want to change the y of acceleration here
		is_jump_interrupted, 
		delta, 
		get_move_direction())
	
	# While jumping/falling, different "gravities" are applied.
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

# apply_gravity could probably serve better inside the "Air" state?
# This applies "gravity" for now
func apply_gravity() -> void:
	var apply_up_gravity := gravity * up_gravity_multiplier
	var apply_down_gravity := gravity * fall_gravity_multiplier
	
	# You could add "_state_machine.state.name == "Air"" for safety?
	if velocity.y < 0.0:
		# Up along the Y-axis is on the neagative.
		velocity.y -= apply_up_gravity
	if velocity.y > 0.0:
		# Down along the Y-axis is on the positive.
		velocity.y += apply_down_gravity
