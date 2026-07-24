extends CharacterBody2D
class_name PickUpObject

@export var weight := 0.0
@export var throw_force := 800.0
@export var ground_friction := 2500.0
@export var stop_threshold := 10.0

var trajectory_steps := 40
var trajectory_step_time := 1.0 / 60.0

@onready var trajectory_line: Line2D = $TrajectoryLine

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
	trajectory_line.visible = true

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
	trajectory_line.visible = false

func _physics_process(delta: float) -> void:
	if holder != null:
		global_position = holder.global_position - offset

		var dir := get_global_mouse_position() - global_position
		if dir.length_squared() > 0.000001:
			aim_direction = dir.normalized()

		_update_trajectory_preview(holder)
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


func _update_trajectory_preview(player: Player) -> void:
	var sim_pos := global_position
	var sim_vel := aim_direction * throw_force + player.velocity
	var gravity := get_gravity()

	var points := PackedVector2Array()
	points.append(sim_pos - global_position)

	var space_state := get_world_2d().direct_space_state
	var query_exclude := [self, player]

	for i in trajectory_steps:
		var prev_pos := sim_pos
		sim_vel += gravity * trajectory_step_time
		sim_pos += sim_vel * trajectory_step_time

		var query := PhysicsRayQueryParameters2D.create(prev_pos, sim_pos)
		query.exclude = query_exclude
		query.collision_mask = collision_mask

		var hit := space_state.intersect_ray(query)
		if hit:
			points.append(hit.position - global_position)
			break

		points.append(sim_pos - global_position)

	trajectory_line.points = points
