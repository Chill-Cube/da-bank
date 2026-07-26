extends Label


var STATE_NAMES := {
	GameState.State.ENTERING: "Click to pick up and throw nearby objects",
	GameState.State.DEFENDING: "Throwing objects hurts the cops",
	GameState.State.STEALING: "Throw objects in the truck to sell them",
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.state_changed.connect(change_text)


func change_text(state : GameState.State):
	if not STATE_NAMES.has(state):
		return

	if STATE_NAMES[state]:
		text = STATE_NAMES[state]
		
		# Reset visibility and alpha for the fade-in
		visible = true
		modulate.a = 0.0
		$notif.play()
		
		# Fade in
		var tween := create_tween()
		tween.set_ignore_time_scale(true)
		tween.tween_property(self, "modulate:a", 1.0, 0.5)
		await tween.finished
		
		# Wait for 5 seconds
		await get_tree().create_timer(5.0, true, false, true).timeout
		
		# Fade out
		tween = create_tween()
		tween.set_ignore_time_scale(true)
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
		await tween.finished
		
		# Hide completely after fade out
		visible = false
