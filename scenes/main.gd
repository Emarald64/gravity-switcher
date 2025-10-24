extends Node2D

func _process(_delta: float) -> void:
	var cameraOffset=$Player.position-$Camera2D.position
	$Camera2D/Label.text=str(cameraOffset)
	if cameraOffset.x>1136:
		$Camera2D.position.x+=1120
	elif cameraOffset.x<16:
		$Camera2D.position.x-=1120
	if cameraOffset.y>632:
		$Camera2D.position.y+=616
	elif cameraOffset.y<16:
		$Camera2D.position.y-=616
