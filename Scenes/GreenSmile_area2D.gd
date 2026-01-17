extends Area2D
class_name Enemy

@export var health := 2
const SPEED = 60
var direction = 1
var triggered := false

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var music: AudioStreamPlayer2D = $"../../music"



func take_damage(amount: int = 1):
	animated_sprite_2d.play("hit")
	health -= amount

	await animated_sprite_2d.animation_finished

	if health <= 0:
		audio_stream_player_2d.play()
		#hide()
		get_node("CollisionShape2D").queue_free()
		await audio_stream_player_2d.finished
		die()
	else:
		animated_sprite_2d.play("run")

func die():
	queue_free()

func _process(delta):
	if ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_2d_left.is_colliding():
		animated_sprite_2d.flip_h = false
		direction = 1

	position.x += direction * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if triggered:
		return
	triggered = true

	# disable player collision (fake death)
	if body.has_node("CollisionShape2D"):
		body.get_node("CollisionShape2D").queue_free()

	# play death sound
	music.stop()
	death_sound.play()

	# start timer AFTER sound
	timer.start()


func _on_timer_timeout() -> void:
	GameData.restore_checkpoint()
	GameData.restore_bullet_checkpoint()
	get_tree().reload_current_scene()
	
