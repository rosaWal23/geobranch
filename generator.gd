extends Node
@onready var grid_map: GridMap = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.05
	
	for x in range(-5,5):
		for y in range(-5,5):
			value = noise.get_noise_2d(x,y)
			grid_map.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
