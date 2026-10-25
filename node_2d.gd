##############################################################
##   AI Generated tester code do not use in final projekt   ##
##############################################################


extends Node2D

@onready var sprite: Sprite2D = $Sprite2D


# Preload your Perlin script (adjust the path if yours is saved elsewhere)
const PerlinScript = preload("res://perlin.gd")

func _ready() -> void:
	var noise_gen = PerlinScript.new()
	noise_gen.seed_perlin = "MyCustomSeed"
	noise_gen.scale_perlin = 10
	
	var width = 256
	var height = 256
	var image = Image.create(width, height, false, Image.FORMAT_RGB8)
	
	
	
	for x in range(width):
		for y in range(height):
			
			
			var val = noise_gen.get_value(x, y)
			
			# Normalize noise from roughly (-1 to 1) to (0.0 to 1.0)
			var color_val = clamp((val + 1.0) * 0.5, 0.0, 1.0)
			
			image.set_pixel(x, y, Color(color_val, color_val, color_val))
			
	var texture = ImageTexture.create_from_image(image)
	sprite.texture = texture
	sprite.position = Vector2(width / 2.0, height / 2.0)
