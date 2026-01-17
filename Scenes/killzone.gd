extends Area2D


@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var music: AudioStreamPlayer2D = $"../music"



func _on_body_entered(body: Node2D) -> void:
	music.stop()
	death_sound.play()
	timer.start()
	

func _on_timer_timeout() -> void:
	GameData.restore_checkpoint()
	GameData.restore_bullet_checkpoint()
	get_tree().reload_current_scene()
