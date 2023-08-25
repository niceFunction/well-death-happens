extends Node2D

onready var splash_skin: Node2D = $SplashSkin
onready var developer_skin: Node2D = $DeveloperSkin

onready var splash_animation_player: AnimationPlayer = $SplashSkin/Splash_AnimationPlayer
onready var developer_animation_player: AnimationPlayer = $DeveloperSkin/Developer_AnimationPlayer

func _ready() -> void:
	splash_animation_player.play("Splash_Anim")


# After the Splash Animation is finished playing, play Developer Animation.
func _on_Splash_animation_finished(anim_name: String) -> void:
	if anim_name == "Splash_Anim":
		#splash_skin.show() == false
		splash_skin.visible = false
		developer_animation_player.play("Developer_Anim")

# After the Developer Animation is finished playing, open the "Main Menu".
func _on_Developer_animation_finished(anim_name: String) -> void:
	if anim_name == "Developer_Anim":
		developer_skin.visible = true
		get_tree().change_scene("res://source/Levels/Main.tscn") # Replace this with "Main Menu"
