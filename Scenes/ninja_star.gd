extends Area2D

@export var speed := 180
@export var lifetime := 2.5

@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var music: AudioStreamPlayer2D = $"../music"
@onready var ninja_star_thrower: Node2D = $"../NinjaStarThrower"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var direction := Vector2.LEFT
var hit := false

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if hit:
		return

	if body is Player:
		hit = true
		collision_shape_2d.set_deferred("disabled", true)

		ninja_star_thrower.stop_throwing()
		music.stop()

		death_sound.play()
		body.die()

		await get_tree().create_timer(0.6).timeout
		get_tree().reload_current_scene()
