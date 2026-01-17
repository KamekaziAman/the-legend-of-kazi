extends Node


# ===============================
# AMMO SYSTEM
# ===============================
var max_bullets := 8
var current_bullets := max_bullets

signal bullets_changed(value)

func reset_ammo():
	current_bullets = max_bullets
	bullets_changed.emit(current_bullets)

func use_bullet() -> bool:
	if current_bullets <= 0:
		return false

	current_bullets -= 1
	bullets_changed.emit(current_bullets)
	return true

func add_bullets(amount := 3):
	current_bullets = min(current_bullets + amount, max_bullets)
	bullets_changed.emit(current_bullets)


# ===============================
# BULLET CHECKPOINT (ADDED)
# ===============================
var checkpoint_bullets := current_bullets

func save_bullet_checkpoint():
	checkpoint_bullets = current_bullets

func restore_bullet_checkpoint():
	current_bullets = checkpoint_bullets
	bullets_changed.emit(current_bullets)


# ===============================
# COINS & GEMS (UNCHANGED)
# ===============================
var coin_counter := 0
var gem_counter := 0

var checkpoint_coins := 0
var checkpoint_gems := 0

func add_coin():
	coin_counter += 1

func add_gem():
	gem_counter += 1

func save_checkpoint():
	checkpoint_coins = coin_counter
	checkpoint_gems = gem_counter

func restore_checkpoint():
	coin_counter = checkpoint_coins
	gem_counter = checkpoint_gems

func reset_all():
	coin_counter = 0
	gem_counter = 0
	checkpoint_coins = 0
	checkpoint_gems = 0
