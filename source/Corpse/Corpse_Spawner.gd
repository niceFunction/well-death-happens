class_name Corpse_Spawner
extends Node2D

onready var player: Player = get_parent() as Player

var corpse_packed_scene := preload("res://source/Corpse/Corpse.tscn")
var corpses_parent: Node2D

func _ready() -> void:
	if player is Player:
		pass
	else:
		print("player property populated with an unexpected non-Player node ")

func spawn_corpse(state: String) -> void:
	var created_corpse := corpse_packed_scene.instance()
	
	created_corpse.corpses_parent = corpses_parent
	
	# What should the Created Corpse do when it's either in the Air or Floor?
	# The "states" are "called" upon in the Player script.
	match state:
		"air":
			created_corpse.position = player.global_position
			corpses_parent.add_child(created_corpse)
		"floor":
			created_corpse.position = player.global_position
			corpses_parent.add_child(created_corpse)
			created_corpse.swap_to_static_body()
