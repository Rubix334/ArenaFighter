extends Node3D
@onready var player1: Player = $Player1

@onready var player2: Player = $Player2

@onready var camera_3d: Camera3D = $Camera3D

var p2attackable = false
var p1attackable = false
var p1attacking = false
var p2attacking = false


func _ready() -> void:
	player1.start_pos = player1.position
	player2.start_pos = player2.position


func _process(delta: float) -> void:
	pass

func _on_player_1_attack() -> void:
	var damage = player1.deal_damage()
	if p2attackable:
		if player2.is_blocking:
			print("P2 is Blocking, no damage dealt")
			return
		player2.health -= damage
		player2.animation_player.play("took_damage")
		print(player2.name + " Health Left: "+ str(player2.health))
		if player1.position.x <= player2.position.x:
			player2.velocity.x += 200
		elif player1.position.x > player2.position.x:
			player2.velocity.x -= 200
		player2.move_and_slide()

func _on_attackzone_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.is_in_group("player2"):
		p2attackable = true
		print("p1 can attack = true")
	else:
		p2attackable = false
		print("p1 can attack = false")

func _on_attackzone_body_exited(body: Node3D) -> void:
	if body.is_in_group("player2"):
		p2attackable = false
		print("p1 can attack = false")
	
func _on_player_2_attack() -> void:
	var damage = player2.deal_damage()
	if p1attackable:
		if player1.is_blocking:
			print("P1 is Blocking, no damage dealt")
			return
		player1.health -= damage
		player1.animation_player.play("took_damage")
		print(player1.name + " Health Left: "+ str(player1.health))
		

func _on_attackzone2_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.is_in_group("player1"):
		p1attackable = true
		print("p2 can attack = true")
	else:
		p1attackable = false
		print("p2 can attack = false")

func _on_attackzone2_body_exited(body: Node3D) -> void:
	if body.is_in_group("player1"):
		p1attackable = false
		print("p2 can attack = false")
