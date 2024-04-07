extends Node

@export var bribe_data : bribeResource
#@export var bribeTelephone : Resource = load("res://Bribes/telephone.tres")
@export var bribeMetronome : Resource = load("res://Bribes/metronome.tres")
@export var bribeLettre : Resource = load("res://Bribes/lettre.tres")
#var instance
@export var tableauObjets : Array = []
var loadScene
@export var tableauNarra : Array = []
@export var text : Label
var resource_data  #: Dictionary = {}
@onready var char = $char
var animation

func _ready():
	animation = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
	text.visible = false 
	tableauObjets = [bribeMetronome, bribeLettre]
	tableauNarra = ["je suis un téléphone dring dring", "je suis un chien bark bark"]
	print (tableauObjets[0])
	for resource in tableauObjets : 
		print ("hbhb")		
		var instance = resource.objetSpriteBroken.instantiate()
		instance.position = resource.emplacement
		instance.bribe_data = resource
		add_child (instance)
		instance.grabObject.connect(_on_grab_object)
		#resource_data = {"resource": resource} #créer un dictionnaire pour stocker la référence à la resource
		#instance.set_meta("resource_data", resource_data) #stocker le dictionnaire dans l'instance

func _on_grab_object(instanceBribe : bribe_instance):
	print ("befifb")
	#var clicked_instance = collider
	#var resource_data = instance.get_meta("resource_data") #on va chercher les données de la ressource
	resource_data = instanceBribe.bribe_data
	if resource_data and resource_data.isImportant : #si l'objet cliqué est important
		loadScene = resource_data.objetSpriteFixed.instantiate() #on load la version non pété de l'objet
		loadScene.onSelfDestroy.connect(onSpriteFixedDestroyed)
		add_child(loadScene)
		char.activeShader(true)
		animation.play("Anxiety")
		instanceBribe.queue_free()
		text.text = resource_data.dialogue
		text.visible = true
		#clicked_instance.queue_free()
		#text.visible = true
		#text.text = resource_data.resource.dialogue
		#for string in tableauNarra :
			#print ("JE VAIS SAUTER")
			


	#var mesh = bribe_data.objetSprite.instantiate()
	#add_child(mesh)


func onSpriteFixedDestroyed():
	text.visible = false
	

	
	#
## ARRAY AVEC LES OBJETS
##dans le ready objet[nomObjet] = recupdata
##DECLARER TEXTE
##DECLARER SPRITE 3D
##DECLARE BOOLEENENEZRKJBEZTUOERN



