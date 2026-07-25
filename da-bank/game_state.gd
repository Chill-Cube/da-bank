extends Node

enum State {
    PLANTING,
    DEFENDING,
    STEALING,
    LEAVING,
}

var current_state : State

func change_state(state : State) -> void:
    current_state = state