tool
# This script should be applied to EVERY level that needs it.
extends Node2D

# For adding a Spawn Point to the level
export (NodePath) var spawn_point = null # Remember to turn off visibility on SpawnPoint.

onready var corpses_parent := $Corpses
onready var player := $Player setget _set_player

onready var transition = $Transition
onready var flag = $Flag

func _ready() -> void:
	# Line Below: WILL CRASH if the next scene doesn't have a Transition object
	# And the animation isn't called.
	transition.transition_into_level()
	_set_player(player)

func _set_player(new_player):
	if player and player.get_node("Corpse_Spawner").is_connected("created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"):
		player.get_node("Corpse_Spawner").disconnect(
			"created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"
		)
		
		player.get_node("StateMachine").disconnect(
			"entered_state", self, "_on_StateMachine_entered_state"
		)
	
	if new_player != null and new_player.has_node("Corpse_Spawner"):
		new_player.get_node("Corpse_Spawner").connect(
			"created_corpse", self, "_on_Corpse_Spawner_corpse_spawned"
		)
		
		new_player.get_node("StateMachine").connect(
			"entered_state", self, "_on_StateMachine_entered_state"
		)
	
	player = new_player

func _on_Corpse_Spawner_corpse_spawned(corpse):
	corpses_parent.add_child(corpse)

func _on_StateMachine_entered_state(state):
	if state == "Spawn":
		player.global_position = get_node(spawn_point).global_position

func change_to_level(next_level, player):
	var current_level = self
	current_level.remove_child(player) # Remove the Player from the current level
	
	var next_level_instance = next_level.instance()
	current_level.player = null
	current_level.spawn_point = null
	next_level_instance.add_child(player) # Add the Player to the Next Level

	var main = get_parent()
	main.remove_child(current_level) # Remove the "old" current level
	main.add_child(next_level_instance) # Add the "new" current level
	
	# Make the Player spawn on the Spawn Point depending on the Level
	player.global_position = next_level_instance.get_node(next_level_instance.spawn_point).global_position
	
	$Camera_Rig.current = false
	next_level_instance.get_node("Camera_Rig").current = true

# Used to remind the Developer that a SpawnPoint is needed for spawn_point export.
func _get_configuration_warning() -> String:
	return "spawn_point export needs a SpawnPoint to function!" if not spawn_point else ""

# The following functions triggers Transitions to the next level
# Currently, EACH new level needs the exact same setup

# LEVEL 1
func _on_Level1_player_collided() -> void:
	transition.transition_out_of_level()

# Changes to Level 2
func _on_Level1_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_out_of_level":
		change_to_level(flag.next_level, player)
	#transition.transition_into_level()

# LEVEL 2
func _on_Level2_player_collided() -> void:
	transition.transition_out_of_level()

# Changes to Level 3
func _on_Level2_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_out_of_level":
		change_to_level(flag.next_level, player)

# LEVEL 3
func _on_Level3_player_collided() -> void:
	transition.transition_out_of_level()

# Changes to Level 4
func _on_Level3_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_out_of_level":
		change_to_level(flag.next_level, player)

# LEVEL 4
func _on_Level4_player_collided() -> void:
	transition.transition_out_of_level()

func _on_Level4_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_out_of_level":
		change_to_level(flag.next_level, player)

# LEVEL 5
func _on_Level5_player_collided() -> void:
	transition.transition_out_of_level()

# Changes to Level 6
func _on_Level5_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_out_of_level":
		change_to_level(flag.next_level, player)

# LEVEL 6

func _on_Level6_player_collided() -> void:
	transition.transition_out_of_level()

func _on_Level6_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_out_of_level":
		change_to_level(flag.next_level, player)
