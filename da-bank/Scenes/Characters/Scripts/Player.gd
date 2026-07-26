extends Character
class_name Player

@export var MONEY := 0.0
var hold_object : PickUpObject = null
var min_distance := 250.0
var double_jump := false
var fallen := false

func _ready():
	animation_key = "Player"
	SignalBus._object_in_truck.connect(get_money)
	super()

func _physics_process(delta: float) -> void:
	if sprite.rotation == deg_to_rad(90): return
	
	
	var health_percent := HEALTH / MAX_HEALTH
	$Hud/Vignette.modulate.a = lerp(1.0, 0.0, health_percent)
	
	if is_on_floor() and !jumping and !animation_playing("jump"):
		fallen = false
		double_jump = false
	if !is_on_floor() and !fallen:
		fallen = true
		double_jump = true
	if Input.is_action_just_pressed("jump") and is_on_floor() or double_jump and Input.is_action_just_pressed("jump"):
		if !jumping:
			double_jump = !double_jump
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
		if dist < closest_dist and dist < min_distance:
			closest_dist = dist
			closest = pickup

	return closest
	
func get_money(money : float, _object : PickUpObject) -> void:
	MONEY += money
	$ching.play()
	
	
var dying := false

func die():
	if dying:
		return
	dying = true
	for child in $Hud.get_children():
		if child.name != "Vignette" and child is Control:
			child.visible = false
			
	var tween := create_tween()

	tween.set_ignore_time_scale(true)

	tween.tween_property(
		$CameraPivot/Camera2D,
		"zoom",
		Vector2.ONE,
		1.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	$Lose.play()
	Engine.time_scale = 0.05
		
	var tween2 := create_tween()

	tween2.set_ignore_time_scale(true)

	tween2.set_parallel(true)

	tween2.tween_property(
		sprite,
		"rotation",
		deg_to_rad(90),
		1.0
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	tween2.tween_property(
		sprite,
		"offset",
		Vector2(57.925, 0),
		1.0
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	await get_tree().create_timer(5.0, true, false, true).timeout
	TransitionScreen.get_node("AnimationPlayer").speed_scale = 0.107 / Engine.time_scale
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Scenes/UI/Lose.tscn")
	

func _input(event: InputEvent) -> void:
	if HEALTH <= 0: return
	if event.is_action_pressed("pick_up"):
		var nearest := find_closest_pickup(global_position)
		if nearest is Bomb and GameState.current_state != GameState.State.PLANTING: return
		
		if nearest and hold_object == null:
			$equip.play()
			SignalBus._pick_up_object.emit(self, nearest)
			hold_object = nearest
		elif hold_object != null:
			if randi_range(1, 100) == 100:
				$secret_throw.play()
			else:
				$throw.play()
			SignalBus._put_down_object.emit(self, hold_object)
			hold_object = null
