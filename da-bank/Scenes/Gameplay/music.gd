extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state_changed.connect(change_music)


func change_music(state : GameState.State):
	if state == GameState.State.DEFENDING: $Cops.play()
