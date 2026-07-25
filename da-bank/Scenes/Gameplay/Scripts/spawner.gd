extends Area2D

@export var max_enemies := 4
@export var spawn_delay := 1.0

var time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time >= spawn_delay:
		time = 0.0
	if time == 0.0:
		if get_node("Enemies").get_child_count() < max_enemies:
			var spawned = preload("res://Scenes/Characters/Enemy.tscn").instantiate()
			get_node("Enemies").add_child(spawned)
			spawned.global_position = get_node("CollisionShape2D").position
			spawned.global_position -= (Vector2(randi_range(-get_node("CollisionShape2D").shape.size.x/2,get_node("CollisionShape2D").shape.size.x/2),randi_range(-get_node("CollisionShape2D").shape.size.y/2,get_node("CollisionShape2D").shape.size.y/2)) * get_node("CollisionShape2D").scale * scale)
	time += delta
