extends Area2D

@export var max_enemies := 4
@export var spawn_delay := 1.0

var time := 0.0

var current_max := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus._bomb_planted.connect(start)

func start():
	current_max = max_enemies

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta

	if time >= spawn_delay:
		time -= spawn_delay

		if get_node("Enemies").get_child_count() < current_max:
			var spawned = preload("res://Scenes/Characters/Enemy.tscn").instantiate()
			get_node("Enemies").add_child(spawned)

			var collision := get_node("CollisionShape2D")
			var shape := collision.shape as RectangleShape2D

			var offset := Vector2(
				randf_range(-shape.size.x * 0.5, shape.size.x * 0.5),
				randf_range(-shape.size.y * 0.5, shape.size.y * 0.5)
			)

			spawned.global_position = collision.to_global(offset)
