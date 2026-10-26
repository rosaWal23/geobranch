extends Node
@onready var grid_map: GridMap = $".."
const perlin = preload("res://perlin.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var noise = perlin.new()
	noise.seed_perlin = "986968976"
	noise.scale_perlin = 100
	for x in range(-50,50):
		for z in range(-50,50):
			var value = floor((noise.get_value(x,z)+1)*5)
			for y in range(value):
				grid_map.set_cell_item(Vector3i(x,y,z),1)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
