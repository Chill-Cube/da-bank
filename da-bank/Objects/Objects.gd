extends Node2D
class_name PickUpObject

@export var weight := 0.0 # subtracts from player_speed
var holder : Player = null
var offset := Vector2(0, 200)

func _ready() -> void:
	SignalBus._pick_up_object.connect(pick_up)
	SignalBus._put_down_object.connect(put_down)
	add_to_group("pickups")
	

func _process(_delta: float) -> void:
	if holder == null: return

	global_position = holder.global_position - offset

func pick_up(player : Player, object : Node2D):
	if object != self: return

	player.SPEED -= weight
	holder = player

func put_down(player : Player, object : Node2D):
	if object != self: return

	player.SPEED += weight
	holder = null
