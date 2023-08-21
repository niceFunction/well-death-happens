extends Area2D

export var tutorial_board: NodePath
onready var tutorial_board_ref: CanvasLayer = get_node_or_null(tutorial_board)

func _ready() -> void:
	tutorial_board_ref.visible = false

func _on_Player_body_entered(body: Node) -> void:
	tutorial_board_ref.visible = true

func _on_Player_body_exited(body: Node) -> void:
	tutorial_board_ref.visible = false
