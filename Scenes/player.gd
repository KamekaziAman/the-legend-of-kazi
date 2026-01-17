extends CharacterBody2D
class_name Player
var bullet_scene = preload("res://Scenes/bullet_sprite.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun_short: AudioStreamPlayer2D = $GunShort
@onready var hud: CanvasLayer = %HUD


var is_dead := false

@export var max_bullets := 8
var current_bullets := max_bullets
var shoot_time: float = 0.9
var shoot_counter: float = 0.0
const SPEED = 200.0
const JUMP_VELOCITY = -280.0
const jump_pad_height: float = -445

func add_bullets():
	current_bullets += 3
	hud.update_bullets(current_bullets)

func die():
	if is_dead:
		return

	is_dead = true
	
	#GameData.reset_ammo()
	
	velocity = Vector2.ZERO
	animated_sprite_2d.pause()
	set_physics_process(false)


func _physics_process(delta):
	shoot_counter += delta

	# ───── SHOOTING LOGIC (PUT IT HERE) ─────
	if Input.is_action_pressed("shoot") and shoot_counter > shoot_time:
		if GameData.use_bullet():
			shoot_counter = 0
			gun_short.play()

			var bullet = bullet_scene.instantiate()
			bullet.direction = -1 if animated_sprite_2d.flip_h else 1
			get_tree().current_scene.add_child(bullet)

			if animated_sprite_2d.flip_h:
				bullet.get_node("bullet_sprite").flip_h = true
				bullet.global_position = global_position + Vector2(-17, 4.2)
			else:
				bullet.get_node("bullet_sprite").flip_h = false
				bullet.global_position = global_position + Vector2(17, 4.2)
		# ❗ NO return here
	# ───────────────────────────────────────
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("left", "right")
	
	
	if is_on_floor():
		if Input.is_action_pressed("shoot"):
			animated_sprite_2d.play("Shooting")
		elif direction != 0:
			animated_sprite_2d.play("runing")
		else:
			animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("jump")
	
			
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
