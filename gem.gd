extends Area2D

@onready var gem_sound: AudioStreamPlayer2D = $gem_sound
@onready var hud: CanvasLayer = %HUD

func _on_body_entered(body: Node2D) -> void:
	gem_sound.play()
	get_node("CollisionShape2D").queue_free()
	hide()
	hud.add_gem()
	await gem_sound.finished
	queue_free()
