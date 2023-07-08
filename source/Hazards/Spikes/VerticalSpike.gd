extends Area2D

func _on_player_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1, true)

# I don't think that this signal is being emitted properly as it should.
# Most likely needs rework, probably need to check the current name
# of the state machine?
#func player_collided_on_spike():
#	emit_signal("player_died_on_spike")
