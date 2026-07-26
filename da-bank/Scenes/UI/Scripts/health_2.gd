extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	max_value = get_parent().get_parent().MAX_HEALTH
	value = get_parent().get_parent().HEALTH
