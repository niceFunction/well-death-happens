extends Control

export var corpses := 10

onready var LifeAmount = $Life_PanelContainer/Margin_Container/Horizontal_Box/LifeAmount_Container/LifeAmount_Label
#onready var game_manager: GameManager = $GameManager
onready var game_manager = get_node("GameManger")
# https://www.youtube.com/watch?v=N4iV1L6xb04
# For this you probably want to poke around in "Flag.gd"

func _ready() -> void:
	LifeAmount.text = str(corpses) # It updates
	pass

func set_corpse_total(new_corpse_amount: int) -> void:
	corpses = new_corpse_amount
	LifeAmount.text = str(corpses)
