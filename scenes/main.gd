extends Node2D

var currentScreen:=Vector2i.ZERO
var currentTileColor:=0

const tileColors:PackedColorArray=[Color.LIGHT_CORAL,Color.CYAN,Color.DEEP_PINK,Color.GREEN_YELLOW,Color.ROYAL_BLUE,Color.ORANGE,Color.GOLDENROD,Color.MEDIUM_PURPLE]

func _ready() -> void:
	updateTileColors()

func _process(_delta: float) -> void:
	updateCamera()
	

func updateCamera() -> void:
	var cameraOffset=$Player.position-$Camera2D.position
	$Camera2D/Label.text=str(cameraOffset)
	if cameraOffset.x>1136:
		$Camera2D.position.x+=1120
		currentTileColor+=1
		updateTileColors()
	elif cameraOffset.x<16:
		$Camera2D.position.x-=1120
		currentTileColor-=1
		updateTileColors()
	if cameraOffset.y>632:
		$Camera2D.position.y+=616
		currentTileColor+=3
		updateTileColors()
	elif cameraOffset.y<16:
		$Camera2D.position.y-=616
		currentTileColor-=3
		updateTileColors()

func updateTileColors() -> void:
	currentTileColor%=9
	$TileMapLayer.self_modulate=tileColors[currentTileColor]
