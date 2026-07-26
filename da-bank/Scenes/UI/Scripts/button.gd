extends Button

func _on_pressed() -> void:
	GameState.change_state(GameState.State.ENTERING)
	get_tree().change_scene_to_file("res://Scenes/Gameplay/test.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
