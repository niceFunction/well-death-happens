extends State

# We probably want to trigger "Corpses" from here
onready var corpse_spawner := $Corpse_Spawner 

func _ready() -> void:
	yield(owner, "ready")

# This function happens once
func _on_Player_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to("Spawn")

func physics_process(delta: float) -> void:
# We probably want to create the Corpses from here?
#From here we probably want some if-statement or check to see what or how the Player died.
	if not owner.is_on_floor():
		handle_death_in_air()
	else:
		handle_death_on_floor()

# These happens twice, why?
func enter(message: Dictionary = {}) -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = false # This is for a "Camera rig" that we might want to reset.
	print("Player died")
	#owner.skin.play("Death") # Leaving this out for now.
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished")
	
func exit() -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = true # This is for a "Camera rig" that we want restored.
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")

# "States" used to check if the player has "died" in the "Air" or "Floor".
func handle_death_in_air() -> void:
	owner.corpse_spawner.spawn_corpse("air") # The Corpse spawner should probably be it's own thing.

func handle_death_on_floor() -> void:
	owner.corpse_spawner.spawn_corpse("floor") # The Corpse spawner should probably be it's own thing.
	# Meaning, that we maybe don't want getting hold of the Player/Corpse_Spawner
