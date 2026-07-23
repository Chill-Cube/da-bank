extends Node2D
@onready var player = get_parent()

@export var follow_speed := 0.15
@export var random_strength := 200.0
@export var shake_fade := 5.0

func _physics_process(_delta: float) -> void:
	var target_pos = player.global_position - player.velocity  * 0.05
	
	global_position = global_position.lerp(
		target_pos,
		follow_speed
	) 
