extends PickUpObject
class_name Bomb

@onready var timer : Timer = $Timer
	
func put_down(player: Player, object: Node2D) -> void:
	if object != self: return
	super.put_down(player, object)
	timer.start()
	
func pick_up(player: Player, object: Node2D) -> void:
	if not timer.is_stopped():
		return
	else:
		super.pick_up(player, object)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	SignalBus._bomb_time_updated.emit(timer.time_left)
