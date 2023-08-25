extends Node2D

onready var game_over_animation_player: AnimationPlayer = $GameOver_AnimationPlayer
onready var label_animation_player: AnimationPlayer = $Label_AnimationPlayer

func _ready() -> void:
	game_over_animation_player.play("GameOver_Anim")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		game_over_animation_player.play("GameOver_Exit_Anim")
	
	if event.is_action_pressed("Exit"):
		get_tree().quit()

func _on_GameOver_animation_finished(anim_name: String) -> void:
	if anim_name == "GameOver_Exit_Anim":
		get_tree().change_scene("res://source/Levels/Main.tscn")
	
	if anim_name == "GameOver_Anim":
		label_animation_player.play("instructions")
