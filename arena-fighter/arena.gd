extends Node3D
@onready var player1: Player = $Player1
@onready var player2: Player = $Player2
@onready var camera_3d: Camera3D = $Camera3D

var p2attackable = false
var p1attackable = false

func _on_player_1_attack() -> void:
	var damage = player1.deal_damage()
	if p2attackable:
		player2.health -= damage
		print(player2.name + " Health Left: "+ str(player2.health))


func _on_attackzone_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.is_in_group("player2"):
		p2attackable = true
		print(true)
	else:
		p2attackable = false
		print(false)
