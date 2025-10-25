extends CharacterBody2D


const SPEED = 600
var gravityUp:=false
@onready var checkpoint:=get_node("../StartPos")
var respawnFlipped:=false
@onready var initalScale:=scale.y
var respawning:=false

func _physics_process(_delta: float) -> void:
	respawning=false
	if Input.is_action_just_pressed("respawn"):
		respawn()
	
	# Add the gravity.
	if not is_on_floor():
		velocity = get_gravity() * (-1 if gravityUp else 1)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		gravityUp=not gravityUp
		scale.y*=-1
		up_direction=-up_direction
		$jumpSound.stream=preload('res://assets/jump2.wav') if gravityUp else preload('res://assets/jump1.wav')
		$jumpSound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = Input.get_axis("move_left", "move_right")*SPEED
	

	move_and_slide()


func respawn() -> void:
	if not respawning:
		respawning=true
		get_node('../Camera2D').add_trauma(0.3)
		position=checkpoint.global_position
		gravityUp=respawnFlipped
		up_direction=Vector2.DOWN if respawnFlipped else Vector2.UP
		scale.y=initalScale * (-1 if respawnFlipped else 1)
