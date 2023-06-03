extends State

func unhandled_input(event: InputEvent) -> void:
	get_parent().unhandled_input(event)

func physics_process(delta: float) -> void:
	var move: = get_parent()
	if owner.is_on_floor():
		if move.get_move_direction().x == 0.0:
			_state_machine.transition_to("Move/Idle") # Set the Character to "Idle" state if no inout is detected.
	else:
		_state_machine.transition_to("Move/Air") # Set the Character state to "Air".
	move.physics_process(delta)

func enter(message: Dictionary = {}) -> void:
	get_parent().enter(message)

func exit() -> void:
	get_parent().exit()
