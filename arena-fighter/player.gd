extends CharacterBody3D
class_name Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attackzone: Area3D = $Attackzone
@onready var timer: Timer = $Timer


const SPEED = 35
const JUMP_VELOCITY = 20

var has_doubleJump = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		##quick down movement (add sound later)
		if velocity.y < 3 and velocity.y > -3:
			animation_player.play("twinkle")
			if Input.is_action_just_pressed("P1Down"):
				velocity += get_gravity() * 3

	# Handle jump.
	if Input.is_action_just_pressed("P1Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		has_doubleJump = false
	elif Input.is_action_just_pressed("P1Up") and not has_doubleJump:
		velocity.y = JUMP_VELOCITY-5
		has_doubleJump = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("P1Left", "P1Right", "ui_up", "ui_down")
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
		attackzone.global_position.x = global_position.x + 6.6
	elif direction.x == -1:
		attackzone.global_position.x = global_position.x - 6.6

func _process(delta: float) -> void:
	# attack logic
	var holdTime := 0.0
	if Input.is_action_pressed("P1Attack"):
		holdTime += delta
	if Input.is_action_just_released("P1Attack"):
		var damage = 5 + holdTime
		print("damage dealt: " + str(damage))
	
	print(holdTime)
