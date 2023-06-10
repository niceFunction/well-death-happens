extends State

func _ready() -> void:
	yield(owner, "ready")

func _on_Player_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to("Spawn")

func physics_process(delta: float) -> void:
# We probably want to create the Corpses from here?
#From here we probably want some if-statement or check to see what or how the Player died.
#	if not owner.is_on_floor():
#		handle_death_in_air() # This is called every frame as long as the player is in the "air".
#	else:
#		handle_death_on_floor()
	return

# These happens twice, why?
func enter(message: Dictionary = {}) -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = false # This is for a "Camera rig" that we might want to reset.
	owner.is_active = false
	owner.skin.play("Death")
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished")
	
func exit() -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = true # This is for a "Camera rig" that we want restored.
	owner.is_active = true
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")

func corpse_creation() -> void:
	if not owner.is_on_floor():
		handle_death_in_air()
	else:
		handle_death_on_floor()

# "States" used to check if the player has "died" in the "Air" or "Floor".
func handle_death_in_air() -> void:
	owner.corpse_spawner.spawn_corpse("air")

func handle_death_on_floor() -> void:
	owner.corpse_spawner.spawn_corpse("floor")

func _on_Player_trigger_a_corpse(new_corpse) -> void:
	owner.just_died = true
#	if owner.emit_signal("trigger_a_corpse", owner.just_died):
#		owner.just_died = true
