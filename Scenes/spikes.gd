extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var music: AudioStreamPlayer2D = $"../../music"

#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		music.stop()
		death_sound.play()
		body.die()
		timer.start()


func _on_timer_timeout() -> void:
	GameData.restore_checkpoint()
	get_tree().reload_current_scene()
