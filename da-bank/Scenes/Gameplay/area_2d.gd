extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if GameState.current_state == GameState.State.ENTERING:
			GameState.change_state(GameState.State.PLANTING)
