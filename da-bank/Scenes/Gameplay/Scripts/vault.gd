extends Area2D

func _ready() -> void:
	SignalBus._bomb_exploded.connect(_explode)

func _on_body_entered(body: Node2D) -> void:
	if body is Bomb:
		body._plant_bomb()

func _explode() -> void:
	get_parent().queue_free()
