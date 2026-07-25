extends Node2D
class_name Bomb

@onready var timer : Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	SignalBus._bomb_time_updated.emit(timer.time_left)
