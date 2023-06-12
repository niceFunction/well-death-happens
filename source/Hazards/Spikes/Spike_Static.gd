extends Area2D

onready var player = get_owner().get_node("Player")

func _ready() -> void:
	connect("body_entered", player, "_has_died")

func _on_player_body_entered(body: Node) -> void:
	#connect("body_entered", player, "_has_died")
	#owner.emit_signal("trigger_a_corpse", player.death.corpse_creation())
	#player.corpse_creation()
	#if player.just_died:
		#player.corpse_creation()
	#print(player.just_died)
	pass
