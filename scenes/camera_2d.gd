extends Camera2D

@export var decay =0.8
@export var max_offset= Vector2(100, 75)
@export var max_roll = 0.1

var trauma = 0.0 
const trauma_power = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0.0)
		var amount = pow(trauma, trauma_power)
		rotation = max_roll * amount * randf_range(-1, 1)
		offset.x = max_offset.x * amount * randf_range(-1, 1)
		offset.y = max_offset.y * amount * randf_range(-1, 1)
	
	var cameraOffset=get_node('../Player').position-position
	$Label.text=str(cameraOffset)
	var colorChange:=0
	# problbly a better way to do this
	while cameraOffset.x>1136:
		position.x+=1120
		colorChange+=1
		cameraOffset=get_node('../Player').position-position
	while cameraOffset.x<16:
		position.x-=1120
		colorChange-=1
		cameraOffset=get_node('../Player').position-position
	while cameraOffset.y>632:
		position.y+=632
		colorChange+=3
		cameraOffset=get_node('../Player').position-position
	while cameraOffset.y<16:
		position.y-=632
		colorChange-=3
		cameraOffset=get_node('../Player').position-position
		
	if colorChange!=0:
		get_parent().updateTileColors(colorChange)

func add_trauma(ammount):
	trauma=min(trauma+ammount,1.0)
