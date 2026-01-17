extends CanvasLayer

@onready var coin_label: Label = $Panel/HBoxContainer/Coin/Coin_Label
@onready var gem_label: Label = $Panel/HBoxContainer/Gem2/Gem_Label
@onready var bullet_label: Label = $Panel/HBoxContainer/Bullet/Bullet_Label
@onready var pause_menu: CanvasLayer = $pauseMenu

func _ready() -> void:
	pause_menu.visible = false
	update_ui()

	# 🔥 BULLET HUD CONNECTION (ADDED)
	GameData.bullets_changed.connect(update_bullets)
	update_bullets(GameData.current_bullets)

func update_ui():
	coin_label.text = str(GameData.coin_counter)
	gem_label.text  = str(GameData.gem_counter)

func add_point():
	GameData.add_coin()
	update_ui()

func add_gem():
	GameData.add_gem()
	update_ui()

# 🔫 Bullet HUD updater (already existed, now USED)
func update_bullets(count: int):
	bullet_label.text = str(count)

func _on_texture_button_toggled(toggled_on: bool) -> void:
	get_tree().paused = toggled_on
	pause_menu.visible = toggled_on
