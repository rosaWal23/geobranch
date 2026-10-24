extends Node

var frequency = 10
var seed_perlin = "Test"

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
	rng.seed= hash(seed_perlin)^hash(str(x)+str(y))
	var vector_angle = rng.randf_range(0,TAU)
	var v_result = Vector2(cos(vector_angle),sin(vector_angle))
	return v_result

func get_value(x: float,y: float):
	
	# convert location to vector for easier math
	var v = Vector2(x,y) 
	
	#get the for vectors at the corners
	var v_nw = get_vector(floor(x),floor(y)) 
	var v_ne = get_vector(floor(x)+1,floor(y))
	var v_se = get_vector(floor(x)+1,floor(y)+1)
	var v_sw = get_vector(floor(x),floor(y)+1)
	
	#calculate the location vectors of the corners
	var v_onw = Vector2(floor(x),floor(y))
	var v_one = Vector2(floor(x)+1,floor(y))
	var v_ose = Vector2(floor(x)+1,floor(y)+1)
	var v_osw = Vector2(floor(x),floor(y)+1)
	
	#calculate the dot product between the corner vectors and the 
	#relative vectors to the corners
	var d_nw = (v-v_onw).dot(v_nw)
	var d_ne = (v-v_one).dot(v_ne)
	var d_se = (v-v_ose).dot(v_se)
	var d_sw = (v-v_osw).dot(v_sw)
	
	#interpolate beweeen the dot-products
	var d_n = d_ne*fade(x-floor(x)) + d_nw*(1-fade(x-floor(x)))
	var d_s = d_se*fade(x-floor(x)) + d_sw*(1-fade(x-floor(x)))
	var result = d_n * (1-fade(y-floor(y))) + d_s * fade(y-floor(y))
	
	return(result)
