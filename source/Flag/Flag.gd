tool
extends Area2D

export var next_scene: PackedScene

onready var current_level = next_scene

onready var player = get_owner().get_node("Player")
#onready var game_manager: GameManager = $GameManager

func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "next_scene needs a Scene/Level to function!" if not next_scene else ""

func teleport() -> void:
	# Reminder: Have some animation here before transitioning to a new level?
	# use the yield(animation_player, "teleport_animation_finished") to wait before transitioning
	get_tree().change_scene_to(next_scene)
	transfer_data_between_scenes(current_level, next_scene)

func transfer_data_between_scenes(old_scene, new_scene):
	new_scene.load_level_parameters(old_scene.player.corpse_parameters)
