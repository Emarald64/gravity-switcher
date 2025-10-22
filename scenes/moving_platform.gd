extends AnimatableBody2D

@export var speed:=200.0
@export var distance:=1000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var changingDir:=(position.x+speed*delta)>=distance or (position.x+speed*delta)<=0
	position.x=pingpong(position.x+(speed*delta),distance)
	if changingDir:
		print('changed direction')
		speed*=-1
