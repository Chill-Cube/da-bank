extends Character
class_name Player

func _ready():
	animation_key = "Player"
	super()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true

	var direction := Input.get_axis("left", "right")
	vel.x = direction * SPEED

	super(delta)
