extends Node2D

enum endBehavour {LOOP,FREE,STOP}

@export var cooldown:=1.0
@export var initialDelay:=0.0
@export var movingVertical:=true
const end:=endBehavour.FREE
@export var spikeSpeed:=600.0
@export var spikeScene:=preload("res://scenes/moving_spike_block.tscn")
@export var endPosition:=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Cooldown.wait_time=cooldown
	await get_tree().create_timer(initialDelay).timeout
	spawn()
	$Cooldown.start()


func spawn() -> void:
	var spike=spikeScene.instantiate()
	spike.position=position
	spike.movingVertical=movingVertical
	spike.end=end
	spike.initailSpeed=spikeSpeed
	spike.z_index=z_index
	if spikeSpeed<0:
		spike.maxDistance=position[1 if movingVertical else 0]
		spike.minDistance=endPosition
	else:
		spike.maxDistance=endPosition
		spike.minDistance=position[1 if movingVertical else 0]
	get_parent().add_child(spike)
	
