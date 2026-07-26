extends AnimationPlayer

var dead := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus._play_bars.connect(start)
	SignalBus._end_cutscene.connect(end)

func start():
	play("letter_boxing")

func end():
	play("normal")
