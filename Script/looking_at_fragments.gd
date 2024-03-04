extends Node3D
var mouse_in_fragment_collider
var timer
var stress_amount
var timer_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_amount = 1
	stress_amount = 0
	mouse_in_fragment_collider = false

func _on_mouse_entered():
	mouse_in_fragment_collider = true
	gestion_anxiete()
	pass # Replace with function body.

func _on_mouse_exited():
	mouse_in_fragment_collider = false
	gestion_anxiete()
	pass # Replace with function body.
	
func _on_anxiete_timer_timeout():
	if mouse_in_fragment_collider:
		stress_amount += 1
	if !mouse_in_fragment_collider:
		stress_amount -= 1
	print(stress_amount)
	pass # Replace with function body.

func gestion_anxiete():
	timer = get_node("collider/anxiete_timer")
	timer.stop()
	timer.start(timer_amount)		
	
#	func _bordel():
		#collision_layer = 1
		#input_ray_pickable = true
		#collision_zone = get_node("fragment/collision_zone")
			#foreach dictionnaire ici
		#if collision_zone.area_entered(): #utiliser signal
		#for fragment in fragzones:
			#if camera.basis == camera.basis.looking_at(fragment.position):
				#print("fragment")
		#pass
		#fraglist = get_tree().get_nodes_in_group("fragments") #array Node3D
		##for each fragment in fraglist : index de fragzonearray = vector3 position de chaque membre de fraglist
		##on fait un deuxième tableau avec les valeurs positions (V3) de chaque fragment
		#for fragment in fraglist:
			#fragzones[fragment] = fragment.position
			##fragzones.append(fragment.position)
			#print("fragment à" + str(fragment.position.x).pad_decimals(2) + str(fragment.position.y).pad_decimals(2) + str(fragment.position.z).pad_decimals(2))
		#pass # Replace with function body.

