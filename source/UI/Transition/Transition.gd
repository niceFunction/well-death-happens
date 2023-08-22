extends CanvasLayer

onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_has_collided := false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func transition_into_level():
	animation_player.play("transition_into_level")
	print("banana")
	
func transition_out_of_level():
	animation_player.play("transition_out_of_level")
