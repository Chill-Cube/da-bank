extends Character
class_name Player

@export var MONEY := 100.0
var hold_object : PickUpObject = null

func _ready():
	animation_key = "Player"
	super()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true

	var direction := Input.get_axis("left", "right")
	vel.x = direction * SPEED

	super(delta)

func find_closest_pickup(from_position: Vector2) -> PickUpObject:
	var pickups := get_tree().get_nodes_in_group("pickups")
	var closest: PickUpObject = null
	var closest_dist := INF

	for pickup in pickups:
		var dist := from_position.distance_to(pickup.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest = pickup

	return closest

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pick_up"):
		var nearest := find_closest_pickup(global_position)
		print(nearest, hold_object)
		if nearest and hold_object == null:
			SignalBus._pick_up_object.emit(self, nearest)
			hold_object = nearest
		elif hold_object != null:
			SignalBus._put_down_object.emit(self, hold_object)
			hold_object = null
