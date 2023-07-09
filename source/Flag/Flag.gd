tool
extends Area2D

export var next_scene: PackedScene
#onready var level: Node2D = $Level

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	get_parent().change_to_scene(next_scene,body)

func _get_configuration_warning() -> String:
	return "next_scene needs a Scene/Level to function!" if not next_scene else ""

func teleport() -> void:
	# Reminder: Have some animation here before transitioning to a new level?
	# use the yield(animation_player, "teleport_animation_finished") to wait before transitioning
	get_tree().change_scene_to(next_scene)
