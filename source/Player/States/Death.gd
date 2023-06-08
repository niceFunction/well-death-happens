extends State

# We probably want to trigger "Corpses" from here
onready var corpse_spawner := $Corpse_Spawner 

func _ready() -> void:
	yield(owner, "ready")
	#_start_position = owner.position

func _on_Player_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to("Death")

func physics_process(delta: float) -> void:
# We probably want to create the Corpses from here?
#From here we probably want some if-statement or check to see what or how the Player died.
#	if not is_on_floor():
#		handle_death_in_air()
#	else:
#		handle_death_on_floor()
	return

# "States" used to check if the player has "died" in the "air" or "Floor".
# Probably needs to be moved somewhere else, maybe.
func handle_death_in_air() -> void:
	corpse_spawner.spawn_corpse("air")

func handle_death_on_floor() -> void:
	corpse_spawner.spawn_corpse("floor")

func enter(message: Dictionary = {}) -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = false # This is for a "Camera rig" that we might want to reset.
	owner.skin.play("Death")
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished")
	
func exit() -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = true # This is for a "Camera rig" that we want restored.
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")
