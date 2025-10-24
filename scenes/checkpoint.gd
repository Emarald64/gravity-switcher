class_name Checkpoint extends Area2D

var checkPointFlipped:=false
var active:=false

func activate(player:Node2D)->void:
	if not active:
		$AnimatedSprite2D.play("active")
		if player.checkpoint is Checkpoint:
			player.checkpoint.get_node("AnimatedSprite2D").play("default")
		player.checkpoint=self 
		player.get_node('../Camera2D').add_trauma(0.3)
		active=true
