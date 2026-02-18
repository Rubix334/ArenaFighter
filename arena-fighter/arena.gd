extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
var attackable = false

func _on_player_1_attack() -> void:
	if attackable:
		


func _on_attackzone_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		attackable = true
