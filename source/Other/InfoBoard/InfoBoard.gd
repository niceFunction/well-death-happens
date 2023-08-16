extends Area2D

var show_info_board := false

func _on_Player_body_entered(body: Node) -> void:
	show_info_board = true
	
	if show_info_board == true:
		pass


func _on_Player_body_exited(body: Node) -> void:
	show_info_board = false
	
	if show_info_board == false:
		pass
