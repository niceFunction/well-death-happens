extends Area2D

onready var player = get_owner().get_node("Player")

func _ready() -> void:
	connect("body_entered", player, "_has_died")

func _on_player_body_entered(body: Node) -> void:
	print("Banana")
	#player.call_deferred("handle_death_in_air")
