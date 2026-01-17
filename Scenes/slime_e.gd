extends Area2D


const SPEED = 60
var direction = 1

@onready var timer: Timer = $Timer
#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft

func _process(delta):
	if ray_cast_2d_right.is_colliding():
		direction = -1
	if ray_cast_2d_left.is_colliding():
		direction = 1

	position.x += direction * SPEED * delta

func _on_body_entered(body: Node2D) -> void:
		timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
