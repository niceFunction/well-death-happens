extends CanvasLayer

onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_has_collided := false

func _ready() -> void:
	#animation_player.play("REF_transition_out")
	animation_player.play("transition_into_level")

func _process(delta: float) -> void:
	if player_has_collided == true:
		transition_out_of_level()

func transition_into_level():
	#animation_player.connect("animation_finished", self, "transition_into_level")
	animation_player.play("transition_into_level")

func transition_out_of_level():
	#animation_player.connect("animation_finished", self, "transition_out_of_level")
	animation_player.play("transition_out_of_level")


func _on_Flag_player_collided() -> void:
	transition_out_of_level()
