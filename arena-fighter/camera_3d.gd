extends Camera3D
@onready var player1: Player = $"../player1"

var default_fov = 58

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fov = default_fov


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if abs(player1.global_position.x) > 50:
		fov = default_fov + (abs(player1.global_position.x)/3.5)
	else:
		fov = default_fov
