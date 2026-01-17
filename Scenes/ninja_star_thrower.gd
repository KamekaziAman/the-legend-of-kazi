extends Node2D

@export var fire_rate := 1.2
var Ninja_star = preload("res://Scenes/ninja_star.tscn")

@onready var launcher = $Launcher
var can_throw := true
var throwing := true

func _ready():
	await get_tree().process_frame
	throw_loop()

func throw_loop():
	while throwing and is_inside_tree():
		throw_star()
		await get_tree().create_timer(fire_rate).timeout

func throw_star():
	var star = Ninja_star.instantiate()
	get_tree().current_scene.add_child.call_deferred(star)

	var offset := Vector2(-10, -4)
	star.global_position = launcher.global_position + offset.rotated(global_rotation)
	star.direction = Vector2.LEFT.rotated(global_rotation)


func stop_throwing():
	throwing = false
