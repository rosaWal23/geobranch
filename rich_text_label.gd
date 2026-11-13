extends RichTextLabel

var fps_history: Array = []
var time_history: Array = []
var window = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	var time = Time.get_ticks_msec()/1000.0
	fps_history.append(fps)
	time_history.append(time)
	while fps_history && (time - time_history[0]) > window:
		fps_history.pop_front()
		time_history.pop_front()
	var min_fps = fps_history.min()
	var max_fps = fps_history.max()
	text = "FPS: %d\n5s Low: %d\n 5s High %d" % [fps,min_fps,max_fps]
