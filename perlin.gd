extends Node

var seed_perlin = "Test"
var scale_perlin = 1

func fade(x: float): 
	#0 for values below 0
	#1 for values above 1
	# smooth interplation inbetween
	if x <= 0:
		return 0
	elif x >= 1:
		return 1
	else:
		return (-2*(x**3))+(3*(x**2))

func get_vector(x: int,y: int):
	var rng = RandomNumberGenerator.new()
	rng.seed= hash(seed_perlin)^hash((str(x)+str(y)).sha1_text())
	var vector_angle = rng.randf_range(0,TAU)
	var v_result = Vector2(cos(vector_angle),sin(vector_angle))
	return v_result

func get_value(x: float,y: float):
	
	var ax = x/scale_perlin
	var ay = y/scale_perlin
	
	# convert location to vector for easier math
	var v = Vector2(ax,ay) 
	
	#get the for vectors at the corners
	var v_nw = get_vector(floor(ax),floor(ay)) 
	var v_ne = get_vector(floor(ax)+1,floor(ay))
	var v_se = get_vector(floor(ax)+1,floor(ay)+1)
	var v_sw = get_vector(floor(ax),floor(ay)+1)
	
	#calculate the location vectors of the corners
	var v_onw = Vector2(floor(ax),floor(ay))
	var v_one = Vector2(floor(ax)+1,floor(ay))
	var v_ose = Vector2(floor(ax)+1,floor(ay)+1)
	var v_osw = Vector2(floor(ax),floor(ay)+1)
	
	#calculate the dot product between the corner vectors and the 
	#relative vectors to the corners
	var d_nw = (v-v_onw).dot(v_nw)
	var d_ne = (v-v_one).dot(v_ne)
	var d_se = (v-v_ose).dot(v_se)
	var d_sw = (v-v_osw).dot(v_sw)
	
	#interpolate beweeen the dot-products
	var d_n = d_ne*fade(ax-floor(ax)) + d_nw*(1-fade(ax-floor(ax)))
	var d_s = d_se*fade(ax-floor(ax)) + d_sw*(1-fade(ax-floor(ax)))
	var result = d_n * (1-fade(ay-floor(ay))) + d_s * fade(ay-floor(ay))
	
	return(result)
