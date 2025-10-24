extends Node2D

#var currentScreen:=Vector2i.ZERO
var currentTileColor:=0

const tileColors:PackedColorArray=[Color.LIGHT_CORAL,Color.CYAN,Color.LIGHT_GREEN,Color.GREEN_YELLOW,Color.ROYAL_BLUE,Color.ORANGE,Color.GOLDENROD,Color.MEDIUM_PURPLE]

func _ready() -> void:
	updateTileColors()
	

func updateTileColors(changeBy:=0) -> void:
	currentTileColor=(currentTileColor+changeBy)%9
	$TileMapLayer.self_modulate=tileColors[currentTileColor]
