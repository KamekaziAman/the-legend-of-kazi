extends Control

@onready var main_button: VBoxContainer = $MainButton
@onready var options: Panel = $Options
@onready var shop: Panel = $Shop

func _ready():
		main_button.visible = true
		options.visible = false
		shop.visible = false
	
func _on_start_pressed() -> void:
	GameData.reset_all()
	GameData.restore_bullet_checkpoint()
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")


func _on_shop_pressed() -> void:
	main_button.visible = false
	options.visible = false
	shop.visible = true


func _on_option_pressed() -> void:
	main_button.visible = false
	options.visible = true
	

func _on_back_pressed() -> void:
	main_button.visible = true
	options.visible = false
	shop.visible = false
	
	
