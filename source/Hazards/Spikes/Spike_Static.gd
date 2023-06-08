extends Area2D

onready var player = get_owner().get_node("Player")

func _ready() -> void:
	connect("body_entered", player, "_died_to_spike")

func _on_player_body_entered(body: Node) -> void:
	#connect("body_entered", player, "_died_to_spike")
	return
