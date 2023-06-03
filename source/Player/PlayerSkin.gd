extends Node2D

signal animation_finished(name)

onready var skin_animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	skin_animation.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")

func _on_AnimationPlayer_animation_finished(animation_name: String) -> void:
	emit_signal("animation_finished", animation_name)

func play(animation_name: String) -> void:
	assert(animation_name in skin_animation.get_animation_list())
	skin_animation.play(animation_name)
