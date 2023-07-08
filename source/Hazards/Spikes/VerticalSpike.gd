extends Area2D

# When a "collision" or body enters, emit this signal
signal player_died_on_spike(player_death)

onready var player = get_owner().get_node("Player")

#func _ready() -> void:
#	connect("body_entered", player, "_has_died")
	

func _on_player_body_entered(body: Node) -> void:
	if "take_damage" in body:
		body.take_damage(1, true)

# I don't think that this signal is being emitted properly as it should.
# Most likely needs rework, probably need to check the current name
# of the state machine?
#func player_collided_on_spike():
#	emit_signal("player_died_on_spike")
