tool
extends Area2D

signal flag_touched(player)

export var next_scene: PackedScene

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	emit_signal("flag_touched", body)
	print("Player in Flag")

func _get_configuration_warning() -> String:
	return "next_scene needs a Scene/Level to function!" if not next_scene else ""

func teleport() -> void:
	# Reminder: Have some animation here before transitioning to a new level?
	# use the yield(animation_player, "teleport_animation_finished") to wait before transitioning
	get_tree().change_scene_to(next_scene)


func _on_Flag_touched(player) -> void:
	pass # Replace with function body.
