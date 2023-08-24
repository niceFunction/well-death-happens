extends Node2D
 
class_name GameManager

export var game_over_scene: PackedScene
onready var LifeAmount = $CorpseUI/Life_PanelContainer/Margin_Container/Horizontal_Box/LifeAmount_Container/LifeAmount_Label
onready var corpse_animation_player: AnimationPlayer = $CorpseUI/AnimationPlayer
onready var player = get_owner().get_node("Player")

func _get_configuration_warning() -> String:
	return "game_over_scene needs a Scene to inform the Player if the game is over!" if not game_over_scene else ""

func _ready() -> void:
	corpse_animation_player.play("START_REF")

func _process(delta: float) -> void:
	LifeAmount.text = str(player.corpse_lives)
	if player.corpse_lives <= 3:
		corpse_animation_player.play("LowLife")
	# In theory, when the "corpse" lives reaches 0, change to "Game Over" scene/level.

func set_corpse_total(new_corpse_amount: int) -> void:
	player.corpse_parameters.lives = new_corpse_amount
	LifeAmount.text = str(player.corpse_parameters.lives)
