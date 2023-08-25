extends Node2D

onready var main_menu_animation_player: AnimationPlayer = $MainMenu_Anim_Skin/MainMenu_AnimationPlayer

func _ready() -> void:
	main_menu_animation_player.play("MainMenu_Anim")
