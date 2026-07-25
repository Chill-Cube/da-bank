extends Node

enum State {
	ENTERING,
	PLANTING,
	DEFENDING,
	STEALING,
	LEAVING,
}

var current_state := State.ENTERING
signal state_changed(state : State)

func change_state(state : State) -> void:
	current_state = state
	state_changed.emit(state)
