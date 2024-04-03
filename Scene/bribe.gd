extends Node

@export var bribe_data : bribeResource
@export var bribeTelephone : Resource = load("res://Bribes/telephone.tres")
@export var bribeChien : Resource = load("res://Bribes/chien.tres")
var instance
@export var tableauObjets : Array = []
var loadScene
@export var tableauNarra : Array = []
@export var text : Label
@export var resource_data : Dictionary = {}


func _ready():
	text.visible = false 
	tableauObjets = [bribeTelephone,bribeChien]
	tableauNarra = ["je suis un téléphone dring dring", "je suis un chien bark bark"]
	print (tableauObjets[0])
	for resource in tableauObjets : 
		print ("hbhb")		
		instance = resource.objetSpriteBroken.instantiate()
		instance.position = resource.emplacement
		add_child (instance)
		instance.grabObject.connect(_on_grab_object)
		resource_data = {"resource": resource} #créer un dictionnaire pour stocker la référence à la resource
		instance.set_meta("resource_data", resource_data) #stocker le dictionnaire dans l'instance

func _on_grab_object():
	print ("befifb")
	var resource_data = instance.get_meta("resource_data") #on va chercher les données de la ressource
	if resource_data and resource_data.resource.isImportant : #si l'objet cliqué est important
		loadScene = resource_data.resource.objetSpriteFixed.instantiate() #on load la version non pété de l'objet
		add_child(loadScene)
		#text.visible = true
		#text.text = resource_data.resource.dialogue
		for string in tableauNarra :
			print ("JE VAIS SAUTER")
			text.text = resource_data.resource.dialogue
			text.visible = true
			
	elif resource_data and resource_data.resource.isImportant == false: #si l'objet est pas important
		var loadScene1 = resource_data.resource.objetSpriteFixed.instantiate()
		add_child(loadScene1)
	
	#var mesh = bribe_data.objetSprite.instantiate()
	#add_child(mesh)
	
func _on_timer_timeout():
	loadScene.queue_free()
	pass # Replace with function body.

	
	
	#
## ARRAY AVEC LES OBJETS
##dans le ready objet[nomObjet] = recupdata
##DECLARER TEXTE
##DECLARER SPRITE 3D
##DECLARE BOOLEENENEZRKJBEZTUOERN



