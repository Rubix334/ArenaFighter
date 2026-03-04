extends CharacterBody3D
class_name Player

@export var controls: Resource = null

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attackzone: Area3D = $Attackzone
@onready var timer: Timer = $Timer
@onready var block_aura: MeshInstance3D = $BlockAura

@export var health := 100.0
var lives := 3
var is_blocking = false

signal attack

const SPEED = 35
const JUMP_VELOCITY = 20

var has_doubleJump = false
var holdTime := 0.0

@export var start_pos = null
var attacktimer = 1

func _physics_process(delta: float) -> void:	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		##quick down movement (add sound later)
		if velocity.y < 3 and velocity.y > -3:
			animation_player.play("twinkle")
			if Input.is_action_just_pressed(controls.down):
				velocity += get_gravity() * 3.5

	# Handle jump.
	if Input.is_action_just_pressed(controls.jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		has_doubleJump = false
	elif Input.is_action_just_pressed(controls.jump) and not has_doubleJump:
		velocity.y = JUMP_VELOCITY-5
		has_doubleJump = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector(controls.move_left, controls.move_right, "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#@print(direction)
	move_and_slide()

	#attack code
	
	if direction.x == 1:
		attackzone.global_position.x = global_position.x + 7
	elif direction.x == -1:
		attackzone.global_position.x = global_position.x - 7.9

func _process(delta: float) -> void:
	# attack logic

	if health <= 0.0:
		died()
	
	if Input.is_action_pressed(controls.attack):
	
		print(holdTime)
		if holdTime < 10:
			holdTime += (delta*2)
		else:
			holdTime = 10
	if Input.is_action_just_released(controls.attack) and attacktimer == 1:
		deal_damage()
		attack.emit()
		attacktimer -= 0.1
		print(name + " damage dealt: " + str(deal_damage()))
		holdTime = 0.0
	
	if attacktimer < 1:
		attacktimer -= 0.02
		if attacktimer <= 0:
			attacktimer = 1
			
	#blocking
	if Input.is_action_pressed(controls.block):
		block_aura.set_visible(true)
		is_blocking = true
	else:
		block_aura.set_visible(false)
		is_blocking = false

func deal_damage() -> float:
	return 5 + holdTime

func died() -> void:
	lives -= 1
	health = 100
	
	
	global_position = start_pos
	
