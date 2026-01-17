extends CanvasLayer

@onready var pause_menu: CanvasLayer = $"."
@onready var options: Panel = $Options
@onready var shop: Panel = $Shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.visible = false
	shop.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_re_start_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	

func _on_option_pressed() -> void:
	get_tree().paused = false
	options.visible = true


func _on_back_pressed() -> void:
	get_tree().paused = true
	options.visible = false
	shop.visible = false


func _on_shop_pressed() -> void:
	#main_button.visible = false
	options.visible = false
	shop.visible = true
