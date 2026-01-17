extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_stream_player_2d.play()
		collision.queue_free()

		# 🔫 Add bullets (global or player-based, your choice)
		GameData.add_bullets(3)

		hide()
		await audio_stream_player_2d.finished
		queue_free()
