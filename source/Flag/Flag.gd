tool
extends Area2D

export var next_scene: PackedScene

# Here we probably want the name of the level & not "next_scene"
# Should it perhaps be empty & in like _process, we set the name
# of the level?
onready var current_level = null

onready var player = get_owner().get_node("Player")

func _process(delta: float) -> void:
	current_level = next_scene

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
	#new_scene.player.corpse_lives = old_scene.player.corpse_lives
