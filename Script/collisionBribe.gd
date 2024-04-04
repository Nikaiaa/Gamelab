extends Node

class_name bribe_instance

var mouse_in_zone_true
signal enableOutline
signal disableOutline
var zoomObjet = preload ("res://Scene/ui_grab_object.tscn")
signal cantMove
var outline = false
@onready var bribe = $"."
var instance
var bribe_data# = bribeResource
signal grabObject(instance : bribe_instance)
var all_children
var instance_clicked

func _ready():
	#get_all($".")
	_on_mouse_exited()
	

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
			#var collider = $Area3D.get_collider()
			grabObject.emit(self)
			#_spawn_bribe()
			#cantMove.connect(_on_cant_move)
			#bribe.queue_free()
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
	
	
func get_all(node:Node):
	all_children = []
	for child in node.get_children():
		all_children.append(child)
	return all_children

func _on_enable_outline():
	outline = true
	print ("outline visible")
	for child in get_children():
		if child is MeshInstance3D:
			for surface in range(0, child.get_surface_override_material_count() ):
				child.get_surface_override_material(surface).next_pass.set("shader_param/enable", true)
	#$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", true)
	pass # Replace with function body.
	
func _on_disable_outline():
	outline = false 
	for child in get_children():
		if child is MeshInstance3D:
			for surface in range(0, child.get_surface_override_material_count() ):
				child.get_surface_override_material(surface).next_pass.set("shader_param/enable", false)
	pass # Replace with function body.

	
