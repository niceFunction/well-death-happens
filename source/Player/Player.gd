extends KinematicBody2D
class_name Player

# REMINDER
# Check the "Death" section in the "Code a Platform Game Character with Godot".

# SOUND FILE FORMATS
# .ogg for music, .wav for SFX

# NOTES #
# TWEAK THE FOLLOWING: 
#	Gravity (Move (Y value in "acceleration_default"))
#	General movement speed (Move (either "max_speed_default" or X value in "acceleration_default"))
#	Jump height
#	Jumping on Walls (How far away do you jump from it, how high up do you jump on it)
#	When Character is animated, see if further tweaking is needed
#	WALL JUMPING MAY NEED A BETTER FIX!!

# TO BE ADDED:
#	Death
#		Create a Corpse on Death where you died
#		Corpses becomes attached to Spikes
#		Character can collide & jump on Corpse
#			Bonus: Player can wall jump on Corpse
#		Corpse are a finite resource, based on a "life" system
#	Spikes
#		Are either animated or static
#		Kill Character on contact
#		If Player dies on an animated Spike, corpse becomes attached to Spike.
#			Spike is extended but the Corpse overlaps on Spike

onready var state_machine: StateMachine = $StateMachine
onready var collider: CollisionShape2D = $CollisionShape2D

# Detect if the Character has collided with a Wall/Floor.
onready var wall_detector: WallDetector = $WallDetector
onready var floor_detector: FloorDetector = $FloorDetector

# 3 variables used for playing animations.
onready var skin: Node2D = $PlayerSkin
onready var animation_player: AnimationPlayer = $PlayerSkin/AnimationPlayer
onready var start_scale: Vector2 = skin.scale

# Used to get access to the velocity variable.
onready var move: State = $StateMachine/Move
# A string that gets "filled" with the animation_player.current_animation.
onready var current_animation: String = ""
# If I want to use a landing animation.
# onready var floor_ray: RayCast2D = $FloorDetector
# onready var idle_timer: Timer = $IdleTimer # Need a Timer Node.

# Triggering the Corpses to spawn should probably be moved to a Death state or something.
onready var corpse_spawner := $Corpse_Spawner 

const FLOOR_NORMAL: = Vector2.UP
var is_active: = true setget set_is_active

func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.disabled = not value

# This function is strictly used for animations (for now).
func _physics_process(delta: float) -> void:
		
	trigger_animation()

# Function that uses condition(s) to trigger different animations.
func trigger_animation() -> void:
	var is_falling = move.velocity.y >= 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("Jump") and is_on_floor() and move.velocity.y <= 0.00
	var is_running := is_on_floor() and not is_zero_approx(move.velocity.x)
	#var has_landed = (code here when the character has landed on the floor).
	#var is_idling = (code here when the character hasn't moved for a while).
	var is_standing = move.velocity.x == 0.0
	# Checks if the current state is "Spawn".
	var is_spawning = state_machine.state.name == "Spawn"
	# Flips the "PlayerSkin" (or rather the "Sprite") along the X axis.	
	if not is_zero_approx(move.velocity.x):
		skin.scale.x = sign(move.velocity.x) * start_scale.x

	if !is_spawning:
		# Different conditions to play different animation depending on the condition.
		if is_jumping and move.velocity.y <= 0.0:
			animation_player.play("Jumping")
		elif is_falling:
			animation_player.play("Falling")
		elif is_running:
			animation_player.play("Walking")
		elif is_on_floor():
			animation_player.play("Standing")

	# Display in text what the current animation is.
	current_animation = animation_player.current_animation
	
# When the Player falls into a pit, just respawn the Player, don't create a Corpse.
func _fell_into_pit(_body: Node) -> void:
	state_machine.transition_to("Spawn")
	move.velocity = Vector2.ZERO
	# Here we could also possibly subtract "life" that's available to the player.

# When the Player has died to a Static Spike, respawn the Player, and create a Corpse.
# Could probably become more generic
# Why is this triggering TWICE & the player isn't really colliding with a Spike yet?
func _died_to_spike(_body: Node) -> void:
	state_machine.transition_to("Death")
	move.velocity = Vector2.ZERO
	# Here we could also possibly subtract "life" that's available to the player.
