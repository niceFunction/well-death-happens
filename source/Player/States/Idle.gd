extends State

onready var jump_buffer: Timer = $JumpBuffer

func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	var move: = get_parent()
	if owner.is_on_floor() and move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run") # Change state to "Run".
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air") # Change state to "Air".

func enter(message: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(message)
	
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO
	
	if not jump_buffer.is_stopped():
		_state_machine.transition_to("Move/Air", {impulse = move.jump_impulse})
		jump_buffer.stop()
	

func exit() -> void:
	get_parent().exit()
