extends Area2D

@onready var coin_sound: AudioStreamPlayer2D = $CoinSound
@onready var hud: CanvasLayer = %HUD


func _on_body_entered(body: Node2D) -> void:
	coin_sound.play()
	hide()
	hud.add_point()
	await coin_sound.finished
	queue_free()
