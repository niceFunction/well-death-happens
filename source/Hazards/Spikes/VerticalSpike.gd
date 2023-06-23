extends Area2D

# When a "collision" or body enters, emit this signal
signal player_died_on_spike(player_death)

onready var player = get_owner().get_node("Player")

func _ready() -> void:
	connect("body_entered", player, "_has_died")

func _on_player_body_entered(body: Node) -> void:
	#player_collided_on_spike()
	if !player.state_machine.state.name == "Spawn":
		player_collided_on_spike()
	return

# I don't think that this signal is being emitted properly as it should.
# Most likely needs rework, probably need to check the current name
# of the state machine?
func player_collided_on_spike():
	#if player.just_died:
	emit_signal("player_died_on_spike")
	print("bananas")
