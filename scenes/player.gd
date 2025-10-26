extends CharacterBody2D


const SPEED = 600
var gravityUp:=false
@onready var checkpoint:=get_node("../StartPos")
var respawnFlipped:=false
@onready var initalScale:=scale.y
var respawning:=false

func _physics_process(_delta: float) -> void:
	if not respawning:
		if Input.is_action_just_pressed("respawn"):
			respawn()
		
		# gravity
		if not is_on_floor():
			velocity = get_gravity() * (-1 if gravityUp else 1)

		# jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			gravityUp=not gravityUp
			scale.y*=-1
			up_direction=-up_direction
			$SoundPlayer.stream=preload('res://assets/jump2.wav') if gravityUp else preload('res://assets/jump1.wav')
			$SoundPlayer.play()

		velocity.x = Input.get_axis("move_left", "move_right")*SPEED
		
		move_and_slide()


func respawn() -> void:
	if not respawning:
		# set flag
		respawning=true
		# play sfx
		$SoundPlayer.stream=preload("res://assets/hurt.wav")
		$SoundPlayer.play()
		# shake camera
		get_node('../Camera2D').add_trauma(0.3)
		
		# wait for 0.5 seconds
		await get_tree().create_timer(0.5).timeout
		
		# move to checkpoint
		position=checkpoint.global_position
		gravityUp=respawnFlipped
		up_direction=Vector2.DOWN if respawnFlipped else Vector2.UP
		scale.y=initalScale * (-1 if respawnFlipped else 1)
		
		get_tree().call_group("reset on death","reset")
		# reset respawn flag
		respawning=false
