extends Character
class_name Player

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true

	var direction := Input.get_axis("left", "right")
	velocity.x = lerp(velocity.x,direction * SPEED,ACCELERATION)

	super(delta)
