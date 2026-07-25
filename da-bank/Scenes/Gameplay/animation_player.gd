extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus._play_bars.emit()
	SignalBus._play_cutscene.emit(4)
	play("enter")
	SignalBus._leave_cutscene.connect(leave)
	
func leave():
	play("leave")
