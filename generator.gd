extends Node
@onready var grid_map: GridMap = $".."
@onready var generated_chunks: GridMap = $GeneratedChunks
@onready var player: Node3D = $"../../Player"
const perlin = preload("res://perlin.gd")
const chunksize: int = 8
const render_distance: int = 10
const max_cunks_per_frame = 4
var plains_noise = perlin.new()
var mountains_noise = perlin.new()
var mountainousness = perlin.new()
var threads: Array[Thread] =[]
const max_threads = 5
var close_threads = false
var semaphore: Semaphore
var mutex: Mutex
var chunk_queue: Array = []
var chunk_queue_to_place: Array = []
var blocks: Dictionary[String,int] = {}

func generate_chunk(chunk_x: int,chunk_z: int,block_dict:Dictionary[String,int]):
	var offset_x = chunk_x * chunksize
	var offset_z = chunk_z * chunksize
	var chunk_data: Array = []
	for x in range(offset_x,offset_x+chunksize,1):
		for z in range(offset_z,offset_z+chunksize,1):
			var mountainousness_value = mountainousness.get_value(x,z)
			var height = 0
			var block_type = 0
			if mountainousness_value > 0.05:
				height = mountains_noise.get_value(x,z)
				block_type = block_dict["Stone"]
			elif mountainousness_value < -0.05:
				height = plains_noise.get_value(x,z)
				block_type = block_dict["Dirt"]
			elif mountainousness_value >= -0.05 && mountainousness_value <= 0.05:
				height = ((mountains_noise.get_value(x,z)*((mountainousness_value+0.05)*10))
						+(plains_noise.get_value(x,z)*(1-((mountainousness_value+0.05)*10))))
				block_type = block_dict["Grass"]
			for y in range(height):
				chunk_data.append([Vector3i(x,y,z),block_type])
	return(chunk_data)
	
func place_chunk(chunk_data: Array):
	for block in chunk_data:
		grid_map.set_cell_item(block[0],block[1])


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
	
	for id in grid_map.mesh_library.get_item_list():
		blocks[grid_map.mesh_library.get_item_name(id)] = id
	
	semaphore = Semaphore.new()
	mutex = Mutex.new()
	for i in range(max_threads):
		
		threads.append(Thread.new())
		threads[i].start(_thread_function.bind(blocks))

 
func _thread_function(block_dict):
	while true :
		semaphore.wait()
		mutex.lock()
		var shutdown = close_threads
		var exersize = chunk_queue[0]
		chunk_queue.pop_front()
		mutex.unlock()
		
		var chunk = generate_chunk(exersize[0],exersize[1],block_dict)
		mutex.lock()
		chunk_queue_to_place.append(chunk)
		mutex.unlock()
		
		
		if shutdown:
			break
		

func _process(delta: float) -> void:
	var player_chunk_x: int = floor(player.position.x/chunksize)
	var player_chunk_z: int = floor(player.position.z/chunksize)
	
	mutex.lock()
	for chunk_x in range(player_chunk_x-render_distance,player_chunk_x+render_distance,1):
		for chunk_z in range(player_chunk_z-render_distance, player_chunk_z+render_distance,1):
			if generated_chunks.get_cell_item(Vector3i(chunk_x,0,chunk_z)) == GridMap.INVALID_CELL_ITEM:
				chunk_queue.append([chunk_x,chunk_z])
				generated_chunks.set_cell_item(Vector3i(chunk_x,0,chunk_z),1)
				semaphore.post()
	mutex.unlock()
	
	
	mutex.lock()
	var chunks_to_place = chunk_queue_to_place.duplicate().slice(0,max_cunks_per_frame-1)
	chunk_queue_to_place = chunk_queue_to_place.slice(max_cunks_per_frame-1,len(chunk_queue_to_place))
	mutex.unlock()
	
	for chunk in chunks_to_place:
		place_chunk(chunk)
		
func _exit_tree() -> void:
	mutex.lock()
	close_threads = true
	mutex.unlock()
	
	for i in range(max_threads):
		semaphore.post()
	
	for thread in threads:
		thread.wait_to_finish()
