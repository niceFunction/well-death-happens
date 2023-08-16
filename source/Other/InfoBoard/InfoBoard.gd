extends Area2D

export var tutorial_board: NodePath
onready var tutorial_board_ref: CanvasLayer = get_node_or_null(tutorial_board)

var show_info_board := false

func _ready() -> void:
	show_info_board = false
	tutorial_board_ref.visible = false

func _on_Player_body_entered(body: Node) -> void:
	show_info_board = true
	
	tutorial_board_ref.visible = true
	
	if show_info_board == true:
		print("Entered Info Board")
#		tutorial_board_ref.visible = true


func _on_Player_body_exited(body: Node) -> void:
	show_info_board = false
	
	tutorial_board_ref.visible = false
	
	if show_info_board == false:
		print("Exited Info Board")
#		tutorial_board_ref.visible = false
