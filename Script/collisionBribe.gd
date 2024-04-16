extends Node

class_name bribe_instance

var mouse_in_zone_true
#signal enableOutline
#signal disableOutline
signal cantMove
var outline = false
var bribe 
var instance
var bribe_data# = bribeResource
#signal grabObject(instance : bribe_instance)
var instance_clicked
@export var audio_stream : AudioStreamPlayer3D
var char : PackedScene
var animation_player : AnimationPlayer
#var anxiete_in : AudioStreamPlayerMP3
#var anxiete_stop : Button
#signal envoiData(instance2 : bribe_instance)

func _ready():
	var bribe = $".".get_parent()
	bribe.enableOutline.connect(_on_enable_outline)
	bribe.disableOutline.connect(_on_disable_outline)
	#scriptBribe.recupData.connect(_on_recup_data)
	_on_mouse_exited()
	print(self.name)
	print($AudioStreamPlayer3D)
	audio_stream.play()

#func _play_audio():
	#var AudioPlayer = $AudioStreamPlayer3D
	#AudioPlayer.play()
	
#func _on_recup_data():
	#envoiData.emit(self)
	

func _on_mouse_entered(): 
	print ("jsuis dans la zone")
	mouse_in_zone_true = true
	#enableOutline.emit()
	
func _on_mouse_exited():
	mouse_in_zone_true = false
	print ("jsuis plus dans la zone")
	#disableOutline.emit()
	pass # Replace with function body.


#func _input(event):
	#if event is InputEventMouseButton && mouse_in_zone_true == true :
		#if event.is_action_pressed("left_click"):
			#print ("object cliqué")
			##var collider = $Area3D.get_collider()
			#grabObject.emit(self)
			#_spawn_bribe()
			#cantMove.connect(_on_cant_move)
			#bribe.queue_free()
			#cantMove.emit(event)
			
			
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

	
