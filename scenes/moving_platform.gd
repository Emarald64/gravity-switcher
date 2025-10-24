extends AnimatableBody2D

@export var speed:=200.0
@export var maxDistance:=1000.0
@export var startX:=position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var changingDir:=(position.x-startX+speed*delta)>=maxDistance or (position.x-startX+speed*delta)<=0
	position.x=pingpong(position.x-startX+(speed*delta),maxDistance)+startX
	if changingDir:
		speed*=-1
