extends Node2D

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	animation_player.play("Blink")
