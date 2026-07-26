extends Character
class_name Enemy

@onready var health_bar := $Health

var players = []
var time = 0.0
var damage := 3.0

func _ready():
	SPEED = 600.0
	ACCELERATION = 0.05
	animation_key = "Enemy"
	super()

func _physics_process(delta: float) -> void:
	if GameState.current_state == GameState.State.LEAVING: return
	
	
	if HEALTH <= 0.0:
		sprite.rotation = lerp(sprite.rotation, deg_to_rad(-90), 0.1)
		sprite.offset = lerp(sprite.offset, Vector2(71.185, 0), 0.1)
		sprite.modulate.a = lerp(sprite.modulate.a, 0.0, 0.1)
	if get_parent().get_parent().get_parent().get_node_or_null("Player") and HEALTH > 0.0:
		var player: Player = get_parent().get_parent().get_parent().get_node("Player")
		var distance_x := player.global_position.x - global_position.x
		if abs(distance_x) != distance_x: vel.x = -SPEED
		else: vel.x = SPEED
		var distance_y := player.global_position.y - global_position.y
		if distance_y <= -125.0 and abs(distance_x) <= 40.0: if is_on_floor(): jumping = true
		if is_on_floor() and is_on_wall():
			jumping = true
	super(delta)


func _on_entered(body: Node2D) -> void:
	if body is Player:
		players.append(body)

func _process(delta: float) -> void:
	health_bar.max_value = MAX_HEALTH
	health_bar.value = HEALTH
	if time >= 0.5:
		time = 0.0
	if time == 0.0 and HEALTH > 0.0:
		for i : Player in players:
			var knockback := (i.global_position - global_position).normalized() * 1000
			knockback.y = 0

			i.take_damage(damage, knockback)
	time += delta
		

func die():
	await(get_tree().create_timer(2).timeout) 
	queue_free()

func _on_exited(body: Node2D) -> void:
	if body is Player:
		if players.has(body):
			players.erase(body)
