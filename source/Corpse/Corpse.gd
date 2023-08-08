class_name Corpse

extends KinematicBody2D

export var gravity := 20.0
export var max_speed := Vector2(0.0, 10.0)

var velocity := Vector2.ZERO
var corpses_parent: Node2D

func _ready() -> void:
	return

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_speed.y)
		
	var collision_info := move_and_collide(velocity)

	if collision_info:
		swap_to_static_body()

# Swaps the KinematicBody2D to a StaticBody2D
func swap_to_static_body() -> void:	
	var static_body_2d := StaticBody2D.new()
	# If you want to have multiple layers/masks, Check the Collision/Mask values & add them together.
	static_body_2d.collision_layer = 2 # That value should be added here.
	static_body_2d.collision_mask = 0
	static_body_2d.name = "StaticCorpse"
	static_body_2d.global_position = position
	replace_by(static_body_2d)
	queue_free()
