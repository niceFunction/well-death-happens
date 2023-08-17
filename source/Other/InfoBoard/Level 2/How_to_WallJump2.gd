extends CanvasLayer

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var label_animation_player: AnimationPlayer = $Label_AnimationPlayer

func _process(delta: float) -> void:
	animation_player.play("HowToWallJump2")
	label_animation_player.play("instructions")
