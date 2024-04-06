extends Camera3D

var shake_intensity = 0.0
var max_shake_intensity = 1
var shake_speed = 0.1

func _process(delta):

	if shake_intensity < max_shake_intensity:
		shake_intensity += delta * shake_speed

	var shake_offset = Vector3(randf_range(-shake_intensity, shake_intensity),
								randf_range(-shake_intensity, shake_intensity),
								randf_range(-shake_intensity, shake_intensity))
	global_transform.origin += shake_offset

func start_shake():
	shake_intensity = 0.0
	set_process(true)

func stop_shake():
	set_process(false)
	global_transform.origin = Vector3.ZERO  # Réinitialiser la position de la caméra
