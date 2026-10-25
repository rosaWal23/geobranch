extends Node
@onready var grid_map: GridMap = $".."





# Called when the node enters the scene tree for the first time.
func _ready() -> void:	var noise = perlin.duplicate(DUPLICATE_DEFAULT | DUPLICATE_SCRIPTS)
	
	
	
#	for x in range(-5,5):
#		for z in range(-5,5):
#			var value = floor((noise.get_noise_2d(x,z)+1)*5)
#			for y in range(value*10):
#				grid_map.set_cell_item(Vector3i(x,y,z),1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
