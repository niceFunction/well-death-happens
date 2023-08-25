extends Node2D

onready var thank_animation_player: AnimationPlayer = $Thanks_AnimationPlayer
onready var label_animation_player: AnimationPlayer = $Label_AnimationPlayer

func _ready() -> void:
	thank_animation_player.play("ThanksForPlaying")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		thank_animation_player.play("ThanksForPlaying_Exit")
	
	if event.is_action_pressed("Exit"):
		get_tree().quit()

func _on_Thanks_animation_finished(anim_name: String) -> void:
	if anim_name == "ThanksForPlaying_Exit":
		get_tree().change_scene("res://source/Levels/Main.tscn")
		
	if anim_name == "ThanksForPlaying":
		label_animation_player.play("instructions")
