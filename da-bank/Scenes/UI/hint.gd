extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# if game state is PLANTING, show the hint then put it away after 5 seconds
	if GameState.current_state == GameState.State.PLANTING:
		# lerp fade in 
		modulate.a = lerp(modulate.a, 1.0, 0.1)
		await get_tree().create_timer(5.0, true, false, true).timeout
		# lerp fade out
		modulate.a = lerp(modulate.a, 0.0, 0.1)
