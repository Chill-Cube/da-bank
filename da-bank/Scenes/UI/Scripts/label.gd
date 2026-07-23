extends Label


func format_time(total_seconds: float) -> String:
	var minutes := int(total_seconds / 60) % 60
	var seconds := int(total_seconds) % 60

	return "%02d:%02d" % [minutes, seconds]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus._bomb_time_updated.connect(update_time)

func update_time(time : float) -> void:
	print("hey")
	text = format_time(time)
