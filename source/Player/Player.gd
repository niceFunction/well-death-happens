extends KinematicBody2D
class_name Player

# REMINDER: For Camera Rig: Watch "The parent Move state" for the Camera Rig (GDQuest, "Code a 2D Platform Game Character with Godot", around 13:20).
# SOUND FILE FORMATS
# .ogg for music, .wav for SFX
#
# NOTES #
# TWEAK THE FOLLOWING: 
#	Gravity (Move (Y value in "acceleration_default"))
#	General movement speed (Move (either "max_speed_default" or X value in "acceleration_default"))
#	Jump height
#	Jumping on Walls (How far away do you jump from it, how high up do you jump on it)
#	WALL JUMPING MAY NEED A BETTER FIX!!

# TO BE ADDED:
#	Death
#		Corpse are a finite resource, based on a "life" system
#	Spikes
#		Static
#			Corpses that are created on Vertical Spikes, are "attached" to it.
#				Bonus: Player can wall jump on Corpse
#				READ THIS: Have an object in the level that has references to Vertical Spike
#				& the Corpse, then from this object, child the Corpse to Vertical
#				Spike.
#		Animated
#			First, has Raycasts that checks if a "Corpse" are on top of this Spike:
#				if there is a "Corpse", stop animating & disable collisions.
#				if there ISN'T a "Corpse" continue animation

const FLOOR_NORMAL: = Vector2.UP

signal corpses_changed(new_corpses)

export var corpse_lives := 10
var corpse_parameters:= {
	"lives": corpse_lives
}

var is_active: = true setget set_is_active

onready var state_machine: StateMachine = $StateMachine
onready var move: State = $StateMachine/Move # Used to get access to the velocity variable.

onready var collider: CollisionShape2D = $CollisionShape2D

# Detect if the Character has collided with a Wall/Floor.
onready var wall_detector: WallDetector = $WallDetector
onready var floor_detector: FloorDetector = $FloorDetector

# Variables used for playing animations.
onready var skin: Node2D = $PlayerSkin
onready var animation_player: AnimationPlayer = $PlayerSkin/AnimationPlayer
onready var start_scale: Vector2 = skin.scale
# What animation is currently playing?
onready var current_animation: String = ""

# Triggering the Corpses to spawn should probably be moved to a Death state or something.
onready var corpse_spawner := $Corpse_Spawner 

func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.set_deferred("disabled", not value)

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
	# Flips the "Player skin" (or rather the "Sprite") along the X axis.	
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
	
# Respawn the Player, DON'T create a "Corpse".
func _fell_into_pit(_body: Node) -> void:
	state_machine.transition_to("Spawn")
	move.velocity = Vector2.ZERO
	#Subtract "life" that's available to the player.

# Create a "Corpse" on Death.
func _has_died(_body: Node) -> void:
	# Checks the current state has been/is "Spawn".
	var has_spawned := state_machine.state.name == "Spawn"
	if !has_spawned:
		state_machine.transition_to("Death")
		move.velocity = Vector2.ZERO
		#take_damage(1)
	# Subtract "life" that's available to the player.

func take_damage(amount: int, should_create_corpse: bool):	
	corpse_lives -= amount
	
	if corpse_lives < 0:
		corpse_lives = 0
		
	var has_spawned := state_machine.state.name == "Spawn"
	if should_create_corpse:
		if !has_spawned:
			state_machine.transition_to("Death")
			move.velocity = Vector2.ZERO
	
	emit_signal("corpses_changed", corpse_lives)
