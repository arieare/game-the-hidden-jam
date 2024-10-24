class_name component_cam_shake extends Node

# Shake variables
var decay = 0.8  # How quickly the shaking stops [0, 1].
var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
var max_roll = 0.1  # Maximum rotation in radians (use sparingly)
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

func shake(amount):
	trauma = min(trauma + amount, 1.0)
	
func apply_shake(cam: Camera3D, delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		var amount = pow(trauma, trauma_power)
		cam.rotation.z = max_roll * amount * randf_range(-1, 1)
		cam.h_offset = max_offset.x * amount * randf_range(-1, 1)
		cam.v_offset = max_offset.y * amount * randf_range(-1, 1)
