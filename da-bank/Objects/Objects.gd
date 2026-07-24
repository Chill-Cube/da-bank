extends CharacterBody2D
class_name PickUpObject

@export var weight := 0.0
@export var throw_force := 800.0
@export var ground_friction := 2500.0
@export var stop_threshold := 10.0

var holder: Player = null
var last_holder: Player = null
var offset := Vector2(0, 200)

var thrown := false
var aim_direction := Vector2.RIGHT

func _ready() -> void:
	SignalBus._pick_up_object.connect(pick_up)
	SignalBus._put_down_object.connect(put_down)
	add_to_group("pickups")

func pick_up(player: Player, object: Node2D) -> void:
	if object != self:
		return

	player.SPEED -= weight
	holder = player
	last_holder = null
	thrown = false
	velocity = Vector2.ZERO

	$CollisionShape2D.disabled = true

func put_down(player: Player, object: Node2D) -> void:
	if object != self:
		return

	player.SPEED += weight

	last_holder = player
	holder = null
	thrown = true

	$CollisionShape2D.disabled = false
	add_collision_exception_with(player)

	velocity = aim_direction * throw_force + player.velocity

func _physics_process(delta: float) -> void:
	if holder != null:
		global_position = holder.global_position - offset

		var dir := get_global_mouse_position() - global_position
		if dir.length_squared() > 0.000001:
			aim_direction = dir.normalized()

		return

	if not thrown:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)

		if abs(velocity.x) < stop_threshold:
			velocity.x = 0.0
			thrown = false

	move_and_slide()

	if last_holder != null:
		if global_position.distance_squared_to(last_holder.global_position) > 64 * 64:
			remove_collision_exception_with(last_holder)
			last_holder = null