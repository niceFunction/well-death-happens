tool
extends Area2D

signal player_collided()

export var next_level: PackedScene

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:	
	#get_parent().call_deferred("change_to_level", next_level, body)
	emit_signal("player_collided")

func _get_configuration_warning() -> String:
	return "next_level needs a Scene/Level to function!" if not next_level else ""
