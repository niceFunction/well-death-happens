class_name RoofDetector
extends Position2D

onready var left_outer_ray: RayCast2D = $LeftOuterRay
onready var left_middle_ray: RayCast2D = $LeftMiddleRay
onready var right_middle_ray: RayCast2D = $RightMiddleRay
onready var right_outer_ray: RayCast2D = $RightOuterRay

# How far will the player be "pushed" away when hitting a "roof ledge"?
export var roof_ledge_bumper: = 5.0

func _physics_process(delta: float) -> void:
	# These functions should probably moved into ONE function, kept separate for now.
	update_roof_rays() # Update the "Roof" rays
	push_off_roof_ledges() # Move the Player away from the "roof ledge".

func update_roof_rays() -> void:
	right_outer_ray.force_raycast_update()
	right_middle_ray.force_raycast_update()
	left_middle_ray.force_raycast_update()
	left_outer_ray.force_raycast_update()

func push_off_roof_ledges() -> void:
	if right_outer_ray.is_colliding() and !right_middle_ray.is_colliding() \
	and !left_middle_ray.is_colliding() and !left_outer_ray.is_colliding():
		owner.global_position.x -= roof_ledge_bumper
	elif left_outer_ray.is_colliding() and !left_middle_ray.is_colliding() \
	and !right_middle_ray.is_colliding() and !right_outer_ray.is_colliding():
		owner.global_position.x += roof_ledge_bumper
