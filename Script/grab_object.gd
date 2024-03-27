extends Node3D
var mouse_in_zone_true
var zoomObjet = preload ("res://Scene/ui_grab_object.tscn")
var frag1
#@onready var player = CharacterBody3D.new()
signal cantMove
var instance
signal enableOutline
signal disableOutline


func _ready():
	mouse_in_zone_true = false
	
	#player.can_move = true 


#func _on_mouse_entered(): 
	#print ("jsuis dans la zone")
	#mouse_in_zone_true = true
	#enableOutline.emit()
	pass # Replace with function body.
#
#func _on_cant_move(_event):
	#print ("cant_move")
	#pass # Replace with function body.

	
	
#func _input(event):
	#if event is InputEventMouseButton && mouse_in_zone_true == true :
		#if event.is_action_pressed("left_click"):
			#print ("object cliqué")
			#_spawn_bribe()
			##_on_cant_move()
			#cantMove.connect(_on_cant_move)
			#cantMove.emit(event)
			
func _on_mouse_exited():
	mouse_in_zone_true = false
	disableOutline.emit()
	pass # Replace with function body.





