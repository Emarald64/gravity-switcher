extends Sprite2D

@export var speed:=200
@export var movingVertical:=true
@export var minDistance:float
@export var maxDistance:float

func _physics_process(delta: float) -> void:
	var changingDir=(getPos()+speed*delta)>=maxDistance or (position.x+speed*delta)<=minDistance
	setPos(pingpong(getPos()+speed*delta-minDistance,maxDistance-minDistance))
	if changingDir:
		speed*=-1

func getPos()->float:
	return position.y if movingVertical else position.x
	
func setPos(value:float)->void:
	if movingVertical:
		position.y=value
	else:
		position.x=value
