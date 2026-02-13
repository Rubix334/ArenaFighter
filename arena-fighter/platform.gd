extends CSGBox3D
@onready var player1: Player = $"../Player1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	use_collision = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player1.position.y-6) > position.y:
		use_collision = true
	else:
		use_collision = false
