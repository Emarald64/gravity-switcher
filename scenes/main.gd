extends Node2D

#var currentScreen:=Vector2i.ZERO
var currentTileColor:=0
@onready var startTime:=Time.get_ticks_msec()

const tileColors:PackedColorArray=[Color.LIGHT_CORAL,Color.GOLDENROD,Color.CYAN,Color.LIGHT_GREEN,Color.GREEN_YELLOW,Color.ROYAL_BLUE,Color.ORANGE,Color.MEDIUM_PURPLE]

func _ready() -> void:
	updateTileColors()

func updateTileColors(changeBy:=0) -> void:
	currentTileColor=(currentTileColor+changeBy)%8
	$Player.modulate=tileColors[currentTileColor].inverted().lightened(0.25)
	get_tree().set_group("Recolor",'modulate',tileColors[currentTileColor])
	get_tree().set_group("Light Recolor",'modulate',tileColors[currentTileColor].lightened(0.5))

func setEndTime() -> void:
	%Timer.text="Time: "+formatTime((Time.get_ticks_msec()-startTime)/1000.0)
	
static func formatTime(time:float) -> String:
	return str(floori(time/60)).pad_zeros(1)+":"+str(floori(time)%60).pad_zeros(2)+"."+str(floori(time*100)%100).pad_zeros(2)
