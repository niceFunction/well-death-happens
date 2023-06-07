extends Area2D

onready var player = get_owner().get_node("Player")

func _ready() -> void:
	connect("body_entered", player, "_player_fell_into_pit")

func _on_Player_body_entered(body: Node) -> void:
	#connect("body_entered", player, "_player_fell_into_pit")
	return
