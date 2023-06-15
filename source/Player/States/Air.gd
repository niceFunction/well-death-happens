extends State

signal jumped

onready var jump_delay: Timer = $JumpDelay

export var acceleration_x: = 5000.0

func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	
	# Reminder: The Jump Delay might need tweaking
	# Coyote Jump, the Player can still jump after a small delay.
	if event.is_action_pressed("Jump"):
		emit_signal("jumped")
		# If the Player "jumps" before 0, jump.
		if move.velocity.y >= 0.0 and jump_delay.time_left > 0.0:
			move.velocity = calculate_jump_velocity(move.jump_impulse)
		else:
			# Otherwise, continue as normal.
			move.unhandled_input(event)
	
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)
	
	# On "var target_state:", Set the Character's state to "Idle" otherwise, set state to "Run".
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0.0 else "Move/Run"
		_state_machine.transition_to(target_state)
	# Here you could in theory have an elif statement that: "Player has landed on Floor, Play Landing animation".
	
	if owner.is_on_wall():
		var wall_normal: float = owner.get_slide_collision(0).normal.x
		_state_machine.transition_to("Move/Wall", {normal = wall_normal, velocity = move.velocity})

func enter(message: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(message)
	move.acceleration.x = acceleration_x
	
	# Affects Left to Right movement.
	if "velocity" in message:
		move.velocity = message.velocity
		move.max_speed.x = max(abs(message.velocity.x), move.max_speed_default.x)
	
	# Add the "impulse" to the jump.
	if "impulse" in message:
		move.velocity += calculate_jump_velocity(message.impulse)
	
	if "wall_jump" in message:
		move.max_speed.x = max(move.max_speed_default.x, abs(move.velocity.x))
		#move.acceleration.y = move.acceleration_default.y # <--This:You want to reset "acceleration" values either when you enter or exit states.
	
	jump_delay.start()

func exit() -> void:
	var move: = get_parent()
	move.exit()
	move.acceleration = move.acceleration_default

func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	var move: = get_parent()
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, impulse),
		move.jump_cutoff,
		1.0,
		Vector2.UP
	)
