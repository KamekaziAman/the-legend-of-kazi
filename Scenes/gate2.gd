extends Area2D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $transition/AnimationPlayer
@onready var music: AudioStreamPlayer2D = $"../music"
@onready var win_sound: AudioStreamPlayer2D = $WinSound

var triggered := false

func _on_body_entered(body: Node2D) -> void:
	if triggered:
		return
	if body.name != "player":
		return

	triggered = true

	freeze_player(body)
	
	music.stop()
	win_sound.play()
	animation_player.play("circle")
	timer.start(animation_player.current_animation_length)


func freeze_player(player):
	# stop movement
	player.velocity = Vector2.ZERO
	player.set_physics_process(false)

	# pause animation
	player.get_node("AnimatedSprite2D").pause()

	# disable collision SAFELY
	player.get_node("CollisionShape2D").set_deferred("disabled", true)


func _on_timer_timeout() -> void:
	GameData.save_checkpoint()
	GameData.save_bullet_checkpoint()
	get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
