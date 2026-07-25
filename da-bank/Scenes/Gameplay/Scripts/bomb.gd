extends PickUpObject
class_name Bomb

@onready var timer : Timer = $Timer

func _ready() -> void:
	add_to_group("pickups")
	
func _plant_bomb() -> void:
	timer.start()
	velocity = Vector2.ZERO

func pick_up(player: Player, object: Node2D) -> void:
	if not timer.is_stopped():
		return
	else:
		super.pick_up(player, object)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	SignalBus._bomb_time_updated.emit(timer.time_left)
