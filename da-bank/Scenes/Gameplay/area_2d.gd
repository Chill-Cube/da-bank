extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(100, Vector2.ZERO)
		if GameState.current_state == GameState.State.ENTERING:
			GameState.change_state(GameState.State.PLANTING)
