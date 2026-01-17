extends Node

var max_bullets := 8
var current_bullets := 8

signal ammo_changed(value)

func can_shoot() -> bool:
	return current_bullets > 0

func use_bullet():
	current_bullets -= 1
	ammo_changed.emit(current_bullets)

func add_bullets(amount := 3):
	current_bullets = min(current_bullets + amount, max_bullets)
	ammo_changed.emit(current_bullets)

func reset():
	current_bullets = max_bullets
	ammo_changed.emit(current_bullets)
