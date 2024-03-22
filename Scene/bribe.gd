extends Node

@export var bribe_data : bribeResource

#
func _ready():
	var mesh = bribe_data.objetSprite.instantiate()
	add_child(mesh)
	
	
	#
## ARRAY AVEC LES OBJETS
##dans le ready objet[nomObjet] = recupdata
##DECLARER TEXTE
##DECLARER SPRITE 3D
##DECLARE BOOLEENENEZRKJBEZTUOERN
