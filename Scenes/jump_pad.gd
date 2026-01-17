extends Node2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.velocity.y = body.jump_pad_height
		animation_player.play("jump_pad")
