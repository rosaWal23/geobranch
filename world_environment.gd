extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	environment.sky.sky_material.set("sky_top_color",Color.from_rgba8(54, 54, 0, 255))
	pass
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
