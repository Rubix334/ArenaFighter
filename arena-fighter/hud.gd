extends Control

@onready var player_1: Player = $"../Player1"
@onready var player_2: Player = $"../Player2"
@onready var player1hud: VBoxContainer = $Player1HUD
@onready var player2hud: VBoxContainer = $Player2HUD

var healthbar1_pos = player1hud.healthbar.front.global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player1hud.healthbar
	pass
