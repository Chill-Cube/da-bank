extends Character
class_name Enemy

@onready var health_bar := $Health

func _ready():
	SPEED = 600.0
	ACCELERATION = 0.05
	animation_key = "Enemy"
	super()

func _physics_process(delta: float) -> void:
	if get_parent().get_parent().get_node_or_null("Player"):
		var player: Player = get_parent().get_parent().get_node("Player")
		var distance_x := player.global_position.x - global_position.x
		if abs(distance_x) != distance_x: vel.x = -SPEED
		else: vel.x = SPEED
		var distance_y := player.global_position.y - global_position.y
		if distance_y <= -125.0 and !player.is_on_floor() and abs(distance_x) <= 40.0: if is_on_floor(): jumping = true
	super(delta)


func _on_entered(body: Node2D) -> void:
	if body is Player:
		print("do the stuff")

func _process(delta: float) -> void:
	health_bar.max_value = MAX_HEALTH
	health_bar.value = HEALTH
