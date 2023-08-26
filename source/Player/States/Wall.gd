extends State

# Reminder: values may need tweaking
export var slide_acceleration := 1600.0
export var max_slide_speed := 400.0
export(float, 0.0, 1.0) var friction_factor := 0.15

# Reminder: These values will need tweaking
# X value is how much the character will jump AWAY from the wall.
# Y value is how much the character will jump UPWARDS from the wall.
export var jump_strength := Vector2(300.0, 500.0)

var _wall_normal := -1.0
var _velocity := Vector2.ZERO

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		jump()

func physics_process(delta: float) -> void:
	# The speed sliding down walls.
	if _velocity.y > max_slide_speed:
		_velocity.y = lerp(_velocity.y, max_slide_speed, friction_factor)
	else:
		_velocity.y += slide_acceleration * delta
	_velocity = owner.move_and_slide(_velocity, owner.FLOOR_NORMAL)
	
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
	
	var move = get_parent()
	var is_moving_away_from_wall := sign(move.get_move_direction().x) == sign(_wall_normal)
	if is_moving_away_from_wall or not owner.wall_detector.is_against_wall():
		_state_machine.transition_to("Move/Air", {velocity = _velocity})

func enter(message: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter(message)
	
	_wall_normal = message.normal
	# Prevent the Character from being able to slide upwards too much.
	if owner.can_wall_jump == true:
		SoundPlayer.play_sound(SoundPlayer.jump)
	_velocity.y = max(message.velocity.y, -max_slide_speed)
	
func exit() -> void:
	get_parent().exit()
	owner.can_wall_jump = false
	if owner.can_wall_jump == false:
		!SoundPlayer.play_sound(SoundPlayer.jump)

func jump() -> void:
	var impulse :=  Vector2(_wall_normal, -1.0) * jump_strength	
	owner.move_and_slide(Vector2(-_wall_normal, 0), owner.FLOOR_NORMAL)
	var collision = owner.get_last_slide_collision()

	if collision:
		var collider = collision.collider
		
		if "can_wall_jump" in collider and collider.can_wall_jump == false:
			return
		
		if "can_wall_jump" in collider and collider.can_wall_jump == true:
			SoundPlayer.play_sound(SoundPlayer.jump)
	
	var message := {
		velocity = impulse,
		wall_jump = true
	}
	_state_machine.transition_to("Move/Air", message)
