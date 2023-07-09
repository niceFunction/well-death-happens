extends Node2D
 
class_name GameManager

#signal corpses_changed(new_corpses)

# How to use Godot's Signals: using custom signals: https://youtu.be/NK_SYVO7lMA?t=754
# The Player probably needs to hold on to "life", maybe?

# The "life" system, the starting "corpses" that the player can use
#export onready var corpse_lives := 10
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
	#print(player.corpse_lives)

func set_corpse_total(new_corpse_amount: int) -> void:
	player.corpse_parameters.lives = new_corpse_amount
	LifeAmount.text = str(player.corpse_parameters.lives)

func change_to_scene(next_scene):
	player.get_parent().remove_child(player)
	
	var scene_instance = next_scene.instance()
	
	scene_instance.add_child(player)
	get_tree().get_root().add_child(scene_instance)
	get_tree().set_current_scene(scene_instance)
