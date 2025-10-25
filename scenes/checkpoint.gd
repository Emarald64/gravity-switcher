class_name Checkpoint extends Area2D

@export var checkPointFlipped:=false
var active:=false

func activate(player:Node2D)->void:
	if not active:
		$AnimatedSprite2D.play("active")
		if player.checkpoint is Checkpoint:
			player.checkpoint.deactivate()
		player.checkpoint=self 
		player.respawnFlipped=checkPointFlipped
		player.get_node('../Camera2D').add_trauma(0.3)
		active=true

func deactivate()->void:
	get_node("AnimatedSprite2D").play("default")
	active=false
