extends Node2D

signal corpses_changed(new_corpses)

# How to use Godot's Signals: using custom signals: https://youtu.be/NK_SYVO7lMA?t=754

# The "life" system, the starting "corpses" that the player can use
export onready var corpses := 10
export var game_over_scene: PackedScene
onready var LifeAmount = $CorpseUI/Life_PanelContainer/Margin_Container/Horizontal_Box/LifeAmount_Container/LifeAmount_Label
onready var corpse_animation_player: AnimationPlayer = $CorpseUI/AnimationPlayer


func _get_configuration_warning() -> String:
	return "game_over_scene needs a Scene to inform the Player if the game is over!" if not game_over_scene else ""

func _ready() -> void:
	LifeAmount.text = str(corpses)
	corpse_animation_player.play("START_REF")

func set_corpse_total(new_corpse_amount: int) -> void:
	corpses = new_corpse_amount
	LifeAmount.text = str(corpses)



func take_damage(amount):
	corpses -= amount
	
	if corpses <= 3:
		corpse_animation_player.play("LowLife")
	
	if corpses < 0:
		corpses = 0
		get_tree().change_scene_to(game_over_scene)
		
	emit_signal("corpses_changed", corpses)
