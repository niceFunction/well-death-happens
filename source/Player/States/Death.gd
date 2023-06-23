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

func corpse_creation() -> void:
	if not owner.is_on_floor():
		handle_death_in_air()
	# the following statement should be something like this maybe?
	# get vertical spike body somehow
	# Or use signals?
	elif owner.just_died:
		handle_death_on_vertical_spike()
	else:
		handle_death_on_floor()

# "States" used to check if the player has "died" in the "Air" or "Floor".
func handle_death_in_air() -> void:
	owner.corpse_spawner.spawn_corpse("air")

func handle_death_on_floor() -> void:
	owner.corpse_spawner.spawn_corpse("floor")

func handle_death_on_vertical_spike() -> void:
#	owner.corpse_spawner.spawn_corpse("vertical spike")
	print("In: handle death on vertical spikes")
	print(owner.just_died)
