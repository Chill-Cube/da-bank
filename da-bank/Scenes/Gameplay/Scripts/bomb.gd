extends PickUpObject
class_name Bomb

@onready var timer : Timer = $Timer
var ticking := false
	
func _plant_bomb() -> void:
	timer.start()
	$FuseSmoke.emitting = true
	velocity = Vector2.ZERO
	
	
	SignalBus._play_bars.emit()
	$Fizz.play()
	
	can_fall = false
	await(get_tree().create_timer(2).timeout) 
	GameState.change_state(GameState.State.DEFENDING)
	$Alarm.play()
	
	await(get_tree().create_timer(0.5).timeout) 
	ticking = true
	SignalBus._bomb_planted.emit()
	SignalBus._play_cutscene.emit(5)

func pick_up(player: Player, object: Node2D) -> void:
	if GameState.current_state != GameState.State.PLANTING:
		return
	else:
		super.pick_up(player, object)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	SignalBus._bomb_time_updated.emit(timer.time_left)
	
func _on_timer_timeout() -> void:
	SignalBus._bomb_exploded.emit()
	$Explosion.play()
	$FuseSmoke.emitting = false
	$Particles.emitting = true
	$Smoke.emitting = true
	$Visual.visible = false
	$Fizz.stop()
	GameState.change_state(GameState.State.STEALING)
