tool
# This script should be applied to EVERY level that needs it.
extends Node2D

# For adding a Spawn Point to the level
export (NodePath) var spawn_point = null # Remember to turn off visibility on SpawnPoint.

onready var corpses_parent := $Corpses
onready var player := $Player setget _set_player

func _ready() -> void:
	# See further below for needed fix for respawn on death issue.
	_set_player(player)

func _set_player(new_player):
	if player and player.get_node("Corpse_Spawner").is_connected("created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"):
		player.get_node("Corpse_Spawner").disconnect(
			"created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"
		)
	
	if new_player != null and new_player.has_node("Corpse_Spawner"):
		new_player.get_node("Corpse_Spawner").connect(
			"created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"
		)
	
	player = new_player

func _on_Corpse_Spawner_corpse_spawned(corpse):
	corpses_parent.add_child(corpse)

func change_to_level(next_level, player):
	var current_level = self
	current_level.call_deferred("remove_child", player)
	
	var next_level_instance = next_level.instance()
	current_level.player = null
	current_level.spawn_point = null
	next_level_instance.call_deferred("add_child",player)

	var main = get_parent()
	main.call_deferred("remove_child", current_level)
	main.call_deferred("add_child", next_level_instance)
	
	player.global_position = next_level_instance.get_node(next_level_instance.spawn_point).global_position

# Used to remind the Developer that a SpawnPoint is needed for spawn_point export.
func _get_configuration_warning() -> String:
	return "spawn_point export needs a SpawnPoint to function!" if not spawn_point else ""
