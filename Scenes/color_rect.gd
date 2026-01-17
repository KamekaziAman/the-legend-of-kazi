extends ColorRect

@onready var mat := material as ShaderMaterial

func _ready():
	var size = get_viewport_rect().size
	mat.set_shader_parameter("screen_width", size.x)
	mat.set_shader_parameter("screen_height", size.y)

	mat.set_shader_parameter("circle_size", 1.1) # fully visible
