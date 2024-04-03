extends Node
var mouse_in_zone_true
signal enableOutline
signal disableOutline
var zoomObjet = preload ("res://Scene/ui_grab_object.tscn")
signal cantMove
var outline = false
@onready var bribe = $"."
var instance
var bribe_data = bribeResource
signal grabObject


func _on_mouse_entered(): 
	print ("jsuis dans la zone")
	mouse_in_zone_true = true
	enableOutline.emit()
	

func _on_mouse_exited():
	mouse_in_zone_true = false
	print ("jsuis plus dans la zone")
	disableOutline.emit()
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton && mouse_in_zone_true == true :
		if event.is_action_pressed("left_click"):
			print ("object cliqué")
			grabObject.emit()
			#_spawn_bribe()
			#cantMove.connect(_on_cant_move)
			cantMove.emit(event)
			
			
			#
#func _on_cant_move(_event):
	#print ("cant_move")
	#pass # Replace with function body.


#func _spawn_bribe():
	##instance = zoomObjet.instantiate()
	##add_child(instance)
	#$Timer.wait_time = 5
	#$Timer.start()
	#print_debug($Timer.time_left)
	#print ($Timer)
	
	

func _on_enable_outline():
	outline = true
	print ("outline visible")
	print ($".".get_child(0).name)
	$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", true)
	pass # Replace with function body.
	
func _on_disable_outline():
	outline = false 
	$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", false)
	pass # Replace with function body.

	
