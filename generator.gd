extends Node
@onready var grid_map: GridMap = $".."
@onready var generated_chunks: GridMap = $GeneratedChunks
@onready var player: Node3D = $"../../Player"
const perlin = preload("res://perlin.gd")
const chunksize: int = 32
var noise = perlin.new()


func generate_chunk(chunk_x: int,chunk_z: int, noise):
	var offset_x = chunk_x * chunksize
	var offset_z = chunk_z * chunksize
	for x in range(offset_x,offset_x+chunksize,1):
		for z in range(offset_z,offset_z+chunksize,1):
			for y in range((noise.get_value(x,z)+1)*5):
				grid_map.set_cell_item(Vector3i(x,y,z),1)
	generated_chunks.set_cell_item(Vector3i(chunk_x,0,chunk_z),1)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.seed_perlin = "986968976"
	noise.scale_perlin = 100





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_chunk_x: int = floor(player.position.x/chunksize)
	var player_chunk_z: int = floor(player.position.z/chunksize)
	for chunk_x in range(player_chunk_x-2,player_chunk_x+2,1):
		for chunk_z in range(player_chunk_z-2, player_chunk_z+2,1):
			if generated_chunks.get_cell_item(Vector3i(chunk_x,0,chunk_z)) == GridMap.INVALID_CELL_ITEM:
				generate_chunk(chunk_x,chunk_z,noise)
				
