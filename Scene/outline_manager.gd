extends Node3D

var outline = false


func _on_enable_outline():
	outline = true
	print ("hesbeguigtj")
	print ($".".get_child(0).name)
	$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", true)
	
	pass # Replace with function body.

func _on_disable_outline():
	outline = false 
	$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", false)
	pass # Replace with function body.





