extends Node

@export var bribe_data : bribeResource
#@export var bribeTelephone : Resource = load("res://Bribes/telephone.tres")
@export var bribeMetronome : Resource = load("res://Bribes/metronome.tres")
@export var bribeLettre : Resource = load("res://Bribes/lettre.tres")
@export var tableauObjets : Array = []
var loadScene
@export var tableauNarra : Array = []
@export var text : Label
var resource_data  #: Dictionary = {}
@onready var char = $char
var animation
var anxieux : AudioStreamPlayer
var rayCast
var verifCollider
signal recupData
var stock_data
var instance
var get_resource
signal enableOutline
signal disableOutline
var outline = false 
var obj_col 



func _ready():
	anxieux = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AudioStreamPlayer")
	animation = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
	rayCast = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/RayCast3D")
	text.visible = false 
	tableauObjets = [bribeMetronome, bribeLettre]
	tableauNarra = ["je suis un téléphone dring dring", "je suis un chien bark bark"]
	print (tableauObjets[0])
	for resource in tableauObjets : 
		print ("hbhb")		
		instance = resource.objetSpriteBroken.instantiate()
		instance.position = resource.emplacement
		instance.bribe_data = resource
		add_child (instance)
		#instance.grabObject.connect(_on_grab_object)
		#instance.envoiData.connect(_on_envoi_data)
		#resource_data = {"resource": resource} #créer un dictionnaire pour stocker la référence à la resource
		#instance.set_meta("resource_data", resource_data) #stocker le dictionnaire dans l'instance


#func _on_envoi_data(instance2 : bribe_instance):
	#stock_data = instance2.bribe_data

func _physics_process(delta):
	if rayCast.is_colliding():
		var collider = rayCast.get_collider()
		obj_col = collider.get_parent()
		get_resource = obj_col.bribe_data
		print (obj_col)
		verifCollider = true
		#recupData.emit()
		enableOutline.emit()
		return (get_resource)
	else : 
		verifCollider = false
		disableOutline.emit()

func _unhandled_input(event):
	if Input.is_action_just_pressed("left_click") and verifCollider:
		print ("SAUTER DU PONT")
		_on_grab_object()

	

func _on_grab_object(): #instanceBribe : bribe_instance
	#var clicked_instance = collider
	#var resource_data = instance.get_meta("resource_data") #on va chercher les données de la ressource
	#resource_data = instanceBribe.bribe_data
	#if stock_data : 
	loadScene = get_resource.objetSpriteFixed.instantiate() #on load la version non pété de l'objet
	loadScene.onSelfDestroy.connect(onSpriteFixedDestroyed)
	add_child(loadScene)
	char.activeShader(true)
	animation.play("Anxiety")
	#instanceBribe.queue_free()
	text.text = get_resource.dialogue
	text.visible = true

		#clicked_instance.queue_free()
		#text.visible = true
		#text.text = resource_data.resource.dialogue
		#for string in tableauNarra :
			#print ("JE VAIS SAUTER")
			
func _on_enable_outline():
	outline = true
	print ("outline visible")
	for child in get_resource.get_children():
		if child is MeshInstance3D:
			for surface in range(0, child.get_surface_override_material_count() ):
				child.get_surface_override_material(surface).next_pass.set("shader_param/enable", true)
	#$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", true)
	pass # Replace with function body.
	
func _on_disable_outline():
	outline = false 
	print ("outline invisible")
	for child in get_resource.get_children():
		if child is MeshInstance3D:
			for surface in range(0, child.get_surface_override_material_count() ):
				child.get_surface_override_material(surface).next_pass.set("shader_param/enable", false)
	pass # Replace with function body.

func onSpriteFixedDestroyed():
	text.visible = false
	

	
	#
## ARRAY AVEC LES OBJETS
##dans le ready objet[nomObjet] = recupdata
##DECLARER TEXTE
##DECLARER SPRITE 3D
##DECLARE BOOLEENENEZRKJBEZTUOERN



