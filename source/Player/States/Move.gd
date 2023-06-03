extends State

# Reminder: The values to the right of the variables, might need changes to a lower value.

# Maximum speed that the Character can reach, X is horizontal max speed, Y can be referred to "maximum fall speed".
export var max_speed_default: = Vector2(300.0, 1500.0)
# A very high value is used on X axis to instantly reach the previous values. 
# Y axis can be considered as "gravity".
export var acceleration_default: = Vector2(5000.0, 1500.0)
# Force of the jump.
export var jump_impulse: = 450.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO # Used for the "move_and_slide()" method

# Makes the Charadcter "jump" & changes the state to "Air".
func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("Jump"):
		_state_machine.transition_to("Move/Air", {impulse = jump_impulse})

func physics_process(delta: float) -> void:
	velocity = calculate_velocity(
		velocity, 
		max_speed, 
		acceleration, 
		delta, 
		get_move_direction())
	
	# Moves the Character.
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)

static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity: = old_velocity
	
	# Calculate based on the Player's current direction.
	new_velocity += move_direction * acceleration * delta
	# Clamp the velocity along the X/Y axises.
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	
	return new_velocity

# Moves the Character to the Left & Right.
static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft"),
		1.0
	)
