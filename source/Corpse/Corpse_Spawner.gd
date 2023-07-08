class_name Corpse_Spawner
extends Node2D

signal created_corpse(corpse)

var corpse_packed_scene := preload("res://source/Corpse/Corpse.tscn")
var corpses_parent: Node2D

func spawn_corpse(state: String) -> void:
	var created_corpse := corpse_packed_scene.instance()
	
	# What should the Created Corpse do when it's either in the Air or Floor?
	# The "states" are "called" upon in the "Death" state via Player/Corpse_Spawner.
	match state:
		"air":
			created_corpse.position = global_position
			#corpses_parent.add_child(created_corpse)
		"floor":
			created_corpse.position = global_position
			#corpses_parent.add_child(created_corpse)
			created_corpse.swap_to_static_body()
		#"vertical spike:"
		#created_corpse.posistion = global_position
		#vertical_spike.add_child(created_corpse)
		#created_corpse.swap_to_static_body()
	emit_signal("created_corpse", created_corpse)
