extends Node

signal player_damaged
signal player_killed

var max_health := 100.0
var health_left := max_health

func reset() -> void:
	health_left = max_health

func player_hurt(amount:float) -> void:
	health_left -= amount
	if health_left <= 0:
		player_killed.emit()
	else:
		player_damaged.emit()
		
	
