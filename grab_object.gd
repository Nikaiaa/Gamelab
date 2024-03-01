extends Area3D
var mouse_in_zone_true
var bribe1 = preload ("res://bribe1.tscn")
var camera 
var frag1
var cameraPosition
var cameraDirection
var cameraRotation
var spawnDistance 
var spawnPos
var look_at_matrix


func _ready():
	mouse_in_zone_true = false
	camera = $"../char"
	set_process_input(true)

func _on_mouse_entered(): 
	print ("jsuis dans la zone")
	mouse_in_zone_true = true
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton && mouse_in_zone_true == true :
		if event.is_action_pressed("left_click"):
			print ("object cliqué")
			set_process_input(false)
			_spawn_bribe()


func _on_mouse_exited():
	mouse_in_zone_true = false
	pass # Replace with function body.

func _spawn_bribe():
	cameraPosition = $"../char".global_transform.origin
	frag1 = $Sprite3D
	cameraDirection = camera.global_transform.basis.z
	spawnDistance = -2
	spawnPos = cameraPosition + cameraDirection* spawnDistance
	var instance = bribe1.instantiate()
	print (camera)
	instance.transform.origin = spawnPos
	look_at_matrix = instance.global_transform.basis.looking_at(cameraDirection, Vector3(0, 1, 0))
	instance.transform.basis = look_at_matrix
	instance.scale =Vector3(4, 4, 4)
	#instance.position.z = camera.position.z-2
	add_child(instance)
	frag1.queue_free()