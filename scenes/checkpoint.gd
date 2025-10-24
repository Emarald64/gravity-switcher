class_name Checkpoint extends Area2D

var checkPointFlipped:=false

func activate(player:Node2D)->void:
	$AnimatedSprite2D.play("active")
	if player.checkpoint is Checkpoint:
		player.checkpoint.get_node("AnimatedSprite2D").play("default")
	player.checkpoint=self 
