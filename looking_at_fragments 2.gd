extends Node3D
var camera
var zone
var fragzones
var fraglist
var x
#DICTIONNAIRE position en tant que clé

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("char/CharacterBody3D/Rotation_Helper/Camera3D")
	fraglist = get_tree().get_nodes_in_group("fragments") #array Node3D
	fragzones = Array()
	#for each fragment in fraglist : index de fragzonearray = vector3 position de chaque membre de fraglist
	#on fait un deuxième tableau avec les valeurs positions (V3) de chaque fragment
	for fragment in fraglist:
		fragzones.append(fragment.position)
		print("fragment à" + str(fragment.position.x).pad_decimals(2) + str(fragment.position.y).pad_decimals(2) + str(fragment.position.z).pad_decimals(2))
pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#foreach dictionnaire ici 
	if camera.basis.looking_at(fragzones[x]):
		print("g peure")
pass
