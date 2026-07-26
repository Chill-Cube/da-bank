extends Button

func _on_pressed() -> void:
	GameState.change_state(GameState.State.ENTERING)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/Gameplay/Game.tscn")
