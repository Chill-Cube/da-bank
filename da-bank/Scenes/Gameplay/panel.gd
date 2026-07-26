extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus._bomb_planted0.connect(beep)


func beep():
	$AnimationPlayer.play("new_animation")
