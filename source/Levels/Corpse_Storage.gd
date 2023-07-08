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
