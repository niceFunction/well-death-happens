extends State

var can_spawn_corpses := false

func _ready() -> void:
	yield(owner, "ready")

func _on_Player_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to("Spawn")

func physics_process(delta: float) -> void:
	return

func enter(message: Dictionary = {}) -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = false # This is for a "Camera rig" that we might want to reset.
	owner.is_active = false
	owner.skin.play("Death")
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished")
	
func exit() -> void:
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = true # This is for a "Camera rig" that we want restored.
	corpse_creation()
	owner.is_active = true
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")

# Depending on if the Player dies on the Floor or not, the Corpse are either created in the air or the floor.
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
