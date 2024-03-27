extends Node

@export var bribe_data : bribeResource
@export var bribeTelephone : Resource = load("res://Bribes/telephone.tres")
@export var bribeChien : Resource = load("res://Bribes/chien.tres")


@export var tableauObjets : Array = []
	


func _ready():
	tableauObjets = [bribeTelephone,bribeChien]
	print (tableauObjets[0])
	for resource in tableauObjets : 
		print ("hbhb")		
		var instance = resource.objetSpriteBroken.instantiate()
		instance.position = resource.emplacement
		add_child (instance)
	#var mesh = bribe_data.objetSprite.instantiate()
	#add_child(mesh)
	


	
	
	#
## ARRAY AVEC LES OBJETS
##dans le ready objet[nomObjet] = recupdata
##DECLARER TEXTE
##DECLARER SPRITE 3D
##DECLARE BOOLEENENEZRKJBEZTUOERN
