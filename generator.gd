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
				height = (mountains_noise.get_value(x,z)+1)*50
				block_type = grid_map.mesh_library.find_item_by_name("Stone")
			elif mountainousness_value < -0.05:
				height = (plains_noise.get_value(x,z)+1)*5
				block_type = grid_map.mesh_library.find_item_by_name("Dirt")
			elif mountainousness_value >= -0.05 && mountainousness_value <= 0.05:
				height = ((mountains_noise.get_value(x,z)+1)*50*((mountainousness_value+0.05)*10))+((plains_noise.get_value(x,z)+1)*5*(1-((mountainousness_value+0.2)*2.5)))
				block_type = grid_map.mesh_library.find_item_by_name("Grass")
			for y in range(height):
				grid_map.set_cell_item(Vector3i(x,y,z),block_type)
	generated_chunks.set_cell_item(Vector3i(chunk_x,0,chunk_z),1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plains_noise.seed_perlin = "986968976"
	plains_noise.scale_perlin = 100
	mountains_noise.seed_perlin = "urbvviz"
	mountains_noise.scale_perlin = 50
	mountainousness.seed_perlin = "hungergames"
	mountainousness.scale_perlin = 1000





# Called every frame. 'delta' is the elapsed tim or 3 layerse since the previous frame.
func _process(delta: float) -> void:
	var player_chunk_x: int = floor(player.position.x/chunksize)
	var player_chunk_z: int = floor(player.position.z/chunksize)
	for chunk_x in range(player_chunk_x-render_distance,player_chunk_x+render_distance,1):
		for chunk_z in range(player_chunk_z-render_distance, player_chunk_z+render_distance,1):
			if generated_chunks.get_cell_item(Vector3i(chunk_x,0,chunk_z)) == GridMap.INVALID_CELL_ITEM:
				generate_chunk(chunk_x,chunk_z)
				
