tool
extends Area2D

export var next_scene: PackedScene

# Reference for "transffering" data: https://www.youtube.com/watch?v=N4iV1L6xb04

# Here we probably want the name of the level & not "next_scene"
# Should it perhaps be empty & in like _process, we set the name
# of the level?
onready var current_level = null

onready var player = get_owner().get_node("Player")
onready var game_manager = get_parent().get_node("GameManager")

func _ready() -> void:
	#print(player.corpse_parameters)
	pass

func _process(delta: float) -> void:
	#current_level = get_tree().current_scene.name
	pass

func _on_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "next_scene needs a Scene/Level to function!" if not next_scene else ""

func teleport() -> void:
	# Reminder: Have some animation here before transitioning to a new level?
	# use the yield(animation_player, "teleport_animation_finished") to wait before transitioning
	get_tree().change_scene_to(next_scene)
	transfer_data_between_scenes(current_level, next_scene)

# At the moment, the "teleportation" works but "data" isn't transferred.
func transfer_data_between_scenes(old_scene, new_scene):
	# It's plausible that "lives" parameters aren't transferred properly.
	game_manager.load_level_parameters(player.corpse_parameters)
	print(player.corpse_parameters)
