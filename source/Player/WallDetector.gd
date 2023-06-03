class_name WallDetector
extends Position2D

# Reminder: Depending on the situation, "ray_bottom" might not be necessary.
onready var ray_bottom: RayCast2D = $RayBottom
onready var ray_top: RayCast2D = $RayTop

export var is_active: = true

func _ready() -> void:
	assert(ray_bottom.cast_to.x >= 0)
	assert(ray_top.cast_to.x >= 0)

func _unhandled_input(event: InputEvent) -> void:
	# Flip the Raycast to the Left.
	if event.is_action_pressed("MoveLeft"):
		scale.x = -1
	# Flip the Raycast to the Right
	if event.is_action_pressed("MoveRight"):
		scale.x = 1

# Reminder: This function may not be needed.
func is_against_ledge() -> bool:
	return is_active and ray_bottom.is_colliding() and not ray_top.is_colliding()
	
func is_against_wall() -> bool:
	return is_active and (ray_bottom.is_colliding() or ray_top.is_colliding())

func get_cast_to_directed() -> Vector2:
	return ray_top.cast_to * scale

func get_top_global_position() -> Vector2:
	return ray_top.global_position
