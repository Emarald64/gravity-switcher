extends Node2D

enum endBehavour {FREE,STOP,LOOP_REVERSE,LOOP_TELEPORT}

@export var initailSpeed:=200.0
@export var movingVertical:=true
@export var minDistance:float
@export var maxDistance:float
@export var end:=endBehavour.LOOP_REVERSE
@onready var startPos:=position
@onready var speed:=initailSpeed
var resetting:=false

func _physics_process(delta: float) -> void:
	if not resetting:
		match end:
			endBehavour.LOOP_REVERSE:
				var changingDir=(getPos()+speed*delta)>=maxDistance or (getPos()+speed*delta)<=minDistance
				setPos(pingpong(getPos()+speed*delta-minDistance,maxDistance-minDistance)+minDistance)
				if changingDir:
					speed*=-1
			endBehavour.LOOP_TELEPORT:
				setPos(fposmod(getPos()+speed*delta-minDistance,maxDistance-minDistance)+minDistance)
			endBehavour.FREE:
				if (getPos()+speed*delta)>maxDistance or (getPos()+speed*delta)<minDistance:
					queue_free()
				else:
					setPos(getPos()+speed*delta)
			endBehavour.STOP:
				if (getPos()+speed*delta)>=maxDistance:
					speed=0
					setPos(maxDistance)
				elif (getPos()+speed*delta)<=minDistance:
					speed=0
					setPos(minDistance)
				else:
					setPos(getPos()+speed*delta)

func getPos()->float:
	return position.y if movingVertical else position.x
	
func setPos(value:float)->void:
	if movingVertical:
		position.y=value
	else:
		position.x=value
#
#func set_speed(value:float)->void:
	#speed=value

func set_speed_unbind_first(_a,value:float):
	speed=value

func reset()->void:
	resetting=true
	await get_tree().physics_frame
	speed=initailSpeed
	position=startPos
	await get_tree().physics_frame
	resetting=false
