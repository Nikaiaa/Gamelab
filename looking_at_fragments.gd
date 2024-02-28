extends Node3D
var camera
var zone
var fragzones = {}
var fraglist
var collision_zone
var input_ray_pickable
var collision_layer 

#DICTIONNAIRE position en tant que clé

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("char/CharacterBody3D/Rotation_Helper").transform
	fraglist = get_tree().get_nodes_in_group("fragments") #array Node3D
	#for each fragment in fraglist : index de fragzonearray = vector3 position de chaque membre de fraglist
	#on fait un deuxième tableau avec les valeurs positions (V3) de chaque fragment
	for fragment in fraglist:
		fragzones[fragment] = fragment.position
		#fragzones.append(fragment.position)
		print("fragment à" + str(fragment.position.x).pad_decimals(2) + str(fragment.position.y).pad_decimals(2) + str(fragment.position.z).pad_decimals(2))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	anxiete()
	pass

func anxiete():
	collision_layer = 1
	input_ray_pickable = true
	collision_zone = get_node("fragment/collision_zone")
		#foreach dictionnaire ici
	if collision_zone.area_entered(): #utiliser signal
		for fragment in fragzones: 
			#if camera.basis == Basis.looking_at(fragment.position):
			print("g peure")
		pass
