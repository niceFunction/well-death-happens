extends Node2D

# This script should be applied to EVERY level that needs it.
onready var corpses_parent := $Corpses
onready var player := $Player

func _ready() -> void:
	player.corpse_spawner.corpses_parent = corpses_parent
