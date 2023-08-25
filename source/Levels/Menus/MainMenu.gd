extends Node2D

onready var main_menu_animation_player: AnimationPlayer = $MainMenu_Anim_Skin/MainMenu_AnimationPlayer

func _ready() -> void:
	main_menu_animation_player.play("MainMenu_Anim")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		main_menu_animation_player.play("MainMenu_ExitAnim")
	
	if event.is_action_pressed("Exit"):
		get_tree().quit()


func _on_MainMenu_animation_finished(anim_name: String) -> void:
	if anim_name == "MainMenu_ExitAnim":
		get_tree().change_scene("res://source/Levels/Main.tscn")
