extends Panel
var dead := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus._death_cutscene.connect(death)
	
func death():
	dead = true
	visible = true
	
func _process(_delta: float) -> void:
	if dead:
		modulate = lerp(modulate, Color("ff000000"), 0.01)
