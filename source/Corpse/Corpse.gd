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
	

# We probably should use the "swap_to_static_body()" function in some way.
# Maybe have some form of "check" that: 
	# if player collided with Vertical Spike:
		# static_body_2d.global_position = vertical_spike.add_child(Corpse).postion
# Vertical Spikes should probably be in a "group" & then the the "Corpse",
# should somehow detect the group
# https://docs.godotengine.org/en/stable/tutorials/scripting/groups.html
# https://gamedev.stackexchange.com/questions/179788/godot-how-do-i-get-the-id-mask-for-a-physics-layer-by-name
# Create a "Group" called "Corpses", then in func below, static_body_2d.add_group("Corpses")

# Swaps the KinematicBody2D to a StaticBody2D
func swap_to_static_body() -> void:
#	if is_in_group("VerticalSpike"):
#		print("floats")
	
	var static_body_2d := StaticBody2D.new()
	# If you want to have multiple layers/masks, Check the Collision/Mask values & add them together.
	static_body_2d.collision_layer = 2 # That value should be added here.
	static_body_2d.collision_mask = 0
	static_body_2d.name = "StaticCorpse"
	static_body_2d.global_position = position
	replace_by(static_body_2d)
	queue_free()

func vertical_spike_corpse(_body: Node) -> void:
	return
