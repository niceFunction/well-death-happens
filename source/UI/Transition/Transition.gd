extends CanvasLayer

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("REF_transition_out")

func _process(delta: float) -> void:
	pass

func transition_into_level():
	animation_player.connect("animation_finished", self, "transition_into_level")
	animation_player.play("transition_into_level")

func transition_out_of_level():
	#animation_player.connect("animation_finished", self, "transition_out_of_level")
	animation_player.play("transition_out_of_level")


func _on_Flag_transition_out() -> void:
	print("banana")
	transition_out_of_level()
