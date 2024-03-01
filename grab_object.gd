extends Area3D
var mouse_in_zone_true
var bribe1 = preload ("res://bribe1.tscn")

func _ready():
	mouse_in_zone_true = false
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
	var instance = bribe1.instantiate()
	instance.position = Vector3(2,0,0)
	add_child(instance)
