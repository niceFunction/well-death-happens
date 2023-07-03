extends Control

export var corpse_total := 10

onready var LifeAmount = $Life_PanelContainer/Margin_Container/Horizontal_Box/LifeAmount_Container/LifeAmount_Label
# https://www.youtube.com/watch?v=N4iV1L6xb04
# For this you probably want to poke around in "Flag.gd"

func _ready() -> void:
	LifeAmount.text = str(corpse_total) # It updates
	pass

func set_corpse_total(new_corpse_amount: int) -> void:
	corpse_total = new_corpse_amount
	LifeAmount.text = str(corpse_total)
