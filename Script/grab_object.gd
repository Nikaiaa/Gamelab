extends Area3D
var mouse_in_zone_true
var zoomObjet = preload ("res://Scene/ui_grab_object.tscn")
var frag1
#@onready var player = CharacterBody3D.new()
signal cantMove
var instance


func _ready():
	mouse_in_zone_true = false
	#player.can_move = true 


func _on_mouse_entered(): 
	print ("jsuis dans la zone")
	mouse_in_zone_true = true
	pass # Replace with function body.

func _on_cant_move(_event):
	print ("cant_move")
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton && mouse_in_zone_true == true :
		if event.is_action_pressed("left_click"):
			print ("object cliqué")
			_spawn_bribe()
			#_on_cant_move()
			cantMove.connect(_on_cant_move)
			cantMove.emit(event)
			
			
func _on_mouse_exited():
	mouse_in_zone_true = false
	pass # Replace with function body.

func _spawn_bribe():
	#cameraPosition = $"../char".global_transform.origin
	frag1 = $Sprite3D
	#cameraDirection = camera.global_transform.basis.z
	#spawnDistance = -2  
	#spawnPos = cameraPosition + cameraDirection* spawnDistance
	instance = zoomObjet.instantiate()
	#print (camera)
	#instance.transform.origin = spawnPos
	#look_at_matrix = instance.global_transform.basis.looking_at(cameraDirection, Vector3(0, 1, 0))
	#instance.transform.basis = look_at_matrix
	#instance.scale =Vector3(4, 4, 4)
	#instance.position.z = camera.position.z-2
	add_child(instance)
	frag1.queue_free()



