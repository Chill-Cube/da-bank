extends Label


const STATE_NAMES := {
	GameState.State.ENTERING: "Go into the bank",
	GameState.State.PLANTING: "Plant the bomb on the vault",
	GameState.State.DEFENDING: "Survive until the bomb explodes!",
	GameState.State.STEALING: "Steal the money and get out!",
	GameState.State.LEAVING: "",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state_changed.connect(change_text)

func change_text(state : GameState.State):
	text = STATE_NAMES[state]
