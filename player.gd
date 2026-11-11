extends Node3D
@export var speed: float = 40.0
@export var mouse_sensitivity: float = .01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Vector3.ZERO
	
	if Input.is_action_pressed("Forward"):
		direction += Vector3(0,0,-1).rotated(Vector3(0,1,0),global_rotation.y)
	if Input.is_action_pressed("Backward"):
		direction += Vector3(0,0,1).rotated(Vector3(0,1,0),global_rotation.y)
	if Input.is_action_pressed("Leftward"):
		direction += Vector3(-1,0,0).rotated(Vector3(0,1,0),global_rotation.y)
	if Input.is_action_pressed("Rightward"):
		direction += Vector3(1,0,0).rotated(Vector3(0,1,0),global_rotation.y)
	if Input.is_action_pressed("Upward"):
		direction += Vector3(0,1,0)
	if Input.is_action_pressed("Downward"):
		direction += Vector3(0,-1,0)
	
	direction = direction.normalized()
	position += direction*speed*delta
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x*mouse_sensitivity)
		global_rotation.x = clamp(rotation.x-event.relative.y*mouse_sensitivity,rad_to_deg(-89),rad_to_deg(89))
