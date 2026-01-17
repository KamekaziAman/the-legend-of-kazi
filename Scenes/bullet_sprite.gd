class_name Bullet
extends Area2D

@export var bullet_speed := 220
@export var damage := 1
var direction := 1   # 1 = right, -1 = left

func _physics_process(delta: float) -> void:
	position.x += bullet_speed * delta * direction

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)

	queue_free()

func _on_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)

	queue_free()
