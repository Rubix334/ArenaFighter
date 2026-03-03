extends Control
@onready var player_1: Player = $"../Player1"

@onready var player_2: Player = $"../Player2"

@onready var front2: ColorRect = $Player2HUD/Healthbar/Front
@onready var front1: ColorRect = $Player1HUD/Healthbar/Front

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	front1.size.x = player_1.health * 5
	front2.size.x = player_2.health * 5 
	pass
