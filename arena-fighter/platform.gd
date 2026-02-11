extends CSGBox3D

var is_above = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	use_collision = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if find_child("player").position.y > position.y:
		use_collision = true
	else:
		use_collision = false
