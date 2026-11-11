extends Node
@onready var grid_map: GridMap = $".."
@onready var generated_chunks: GridMap = $GeneratedChunks
@onready var player: Node3D = $"../../Player"
const perlin = preload("res://perlin.gd")
const chunksize: int = 8
const render_distance: int = 10
var plains_noise = perlin.new()
var mountains_noise = perlin.new()
var mountainousness = perlin.new()


func generate_chunk(chunk_x: int,chunk_z: int):
	var offset_x = chunk_x * chunksize
	var offset_z = chunk_z * chunksize
	for x in range(offset_x,offset_x+chunksize,1):
		for z in range(offset_z,offset_z+chunksize,1):
			var mountainousness_value = mountainousness.get_value(x,z)
			var height = 0
			var block_type = 0
			if mountainousness_value > 0.05:
				height = mountains_noise.get_value(x,z)
				block_type = grid_map.mesh_library.find_item_by_name("Stone")
			elif mountainousness_value < -0.05:
				height = plains_noise.get_value(x,z)
				block_type = grid_map.mesh_library.find_item_by_name("Dirt")
			elif mountainousness_value >= -0.05 && mountainousness_value <= 0.05:
				height = ((mountains_noise.get_value(x,z)*((mountainousness_value+0.05)*10))
						+(plains_noise.get_value(x,z)*(1-((mountainousness_value+0.05)*10))))
				block_type = grid_map.mesh_library.find_item_by_name("Grass")
			for y in range(height):
				grid_map.set_cell_item(Vector3i(x,y,z),block_type)
	generated_chunks.set_cell_item(Vector3i(chunk_x,0,chunk_z),1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plains_noise.seed_perlin = "986968976"
	plains_noise.scale_perlin = 100
	plains_noise.min_y = 0
	plains_noise.y_range = 10
	
	mountains_noise.seed_perlin = "ben is the greatest"
	mountains_noise.scale_perlin = 50
	mountains_noise.min_y = 0
	mountains_noise.y_range = 100
	
	mountainousness.seed_perlin = "hungergames"
	mountainousness.scale_perlin = 700
 


func _process(delta: float) -> void:
	var player_chunk_x: int = floor(player.position.x/chunksize)
	var player_chunk_z: int = floor(player.position.z/chunksize)
	var chunk_queue: Array = []
	for chunk_x in range(player_chunk_x-render_distance,player_chunk_x+render_distance,1):
		for chunk_z in range(player_chunk_z-render_distance, player_chunk_z+render_distance,1):
			if generated_chunks.get_cell_item(Vector3i(chunk_x,0,chunk_z)) == GridMap.INVALID_CELL_ITEM:
				chunk_queue.append([chunk_x,chunk_z])
	if chunk_queue:
		for i in range(min(len(chunk_queue),5)):
			generate_chunk(chunk_queue[0][0],chunk_queue[0][1])
			chunk_queue.pop_front()
