extends State

func _ready() -> void:
	yield(owner, "ready")

func _on_PlayerSkin_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to("Move/Air")

func enter(message: Dictionary = {}) -> void:
	owner.is_active = false
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = false # This is for a "Camera rig" that we might want to reset.
	owner.skin.play("Spawning")
	owner.skin.connect("animation_finished", self, "_on_PlayerSkin_animation_finished")

func exit() -> void:
	owner.is_active = true
	#if owner.camera_rig:
	#	owner.camera_rig.is_active = true # This is for a "Camera rig" that we want restored.
	owner.skin.disconnect("animation_finished", self, "_on_PlayerSkin_animation_finished")
