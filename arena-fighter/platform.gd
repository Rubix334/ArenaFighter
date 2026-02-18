extends CSGBox3D
@onready var player1: Player = $"../Player1"
@onready var player2: Player = $"../Player2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#use_collision = false
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player1.position.y-6) > position.y:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
	else:
		set_collision_mask_value(1, false)
		set_collision_layer_value(1, false)
	
	if (player2.position.y-6) > position.y:
		set_collision_layer_value(2, true)
		set_collision_mask_value(2, true)
	else:
		set_collision_layer_value(2, false)
		set_collision_mask_value(2, false)
