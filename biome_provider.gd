extends Node

const perlin = preload("res://perlin.gd")

var main_block: int = 0
var octaves: int = 0
var frequencys: Array[int] = []
var amplitudes: Array[int] = []
var heights: Array[int] = []
var noise_providers: Array[perlin] = []
var main_seed = "220i"
var top_layers = []
var bottom_layers = []
var fixed = []

func load_biome(config: ConfigFile):
	for section in config.get_sections():
		match section:
			"meta":
				main_block = config.get_value(section,"main_block")
				for i in range(config.get_value(section,"max_height")):
					fixed.append(null)
			var check when check.begins_with("octave"):
				noise_providers.append(null)
				frequencys.append(config.get_value(section,"frequency"))
				amplitudes.append(config.get_value(section,"amplitude"))
				heights.append(config.get_value(section,"min_y"))
			var check when check.begins_with("surface_rule"):
				match config.get_value(section,"type"):
					"y_range":
						var block = config.get_value(section,"block")
						for i in range(config.get_value(section,"min"),config.get_value(section,"max")):
							fixed[i] = block
					"top":
						var block = config.get_value(section,"block")
						for i in range(config.get_value(section,"thickness")):
							top_layers.append(block)
					"bottom":
						var block = config.get_value(section,"block")
						for i in range(config.get_value(section,"thickness")):
							bottom_layers.append(block)
		init_providers()

func init_providers():
	var rng = RandomNumberGenerator.new()
	rng.seed = main_seed
	for i in range(len(noise_providers)):
		noise_providers[i] = perlin.new()
		noise_providers[i].scale_perlin = frequencys[i]
		noise_providers[i].y_range = amplitudes[i]
		noise_providers[i].min_y = heights[i]
		noise_providers[i].seed_perlin = rng.randi_range(0,1000000000)
		
		
func get_height(x,z):
	var height: int = 0
	for provider in noise_providers:
		height += provider.get_value(x,z)
	return height

func make_slice(height):
	var slice = fixed.slice(0,height)
	for i in range(len(bottom_layers)):
		slice[i] = bottom_layers[i]
	for i in range(len(top_layers)):
		slice[-i] = top_layers[i]
	return slice
