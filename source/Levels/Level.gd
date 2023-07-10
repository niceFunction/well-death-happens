extends Node2D

# This script should be applied to EVERY level that needs it.
onready var corpses_parent := $Corpses
onready var player := $Player setget _set_player

func _ready() -> void:
	_set_player(player)

func _set_player(player):
	if player.has_node("Corpse_Spawner"):
		player.get_node("Corpse_Spawner").connect(
			"created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"
		)
		player.connect("tree_exiting", self,"_on_Player_tree_exiting")

func _on_Corpse_Spawner_corpse_spawned(corpse):
	corpses_parent.add_child(corpse)

func _on_Player_tree_exiting():
	player.get_node("Corpse_Spawner").disconnect(
		"created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"
	)

func change_to_level(next_level, player):
	var current_level = self
	current_level.call_deferred("remove_child", player)
	
	var next_level_instance = next_level.instance()
	next_level_instance.call_deferred("add_child",player)

	var main = get_parent()
	main.call_deferred("remove_child", current_level)
	main.call_deferred("add_child", next_level_instance)

