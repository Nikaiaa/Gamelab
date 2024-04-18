extends Node

@export var bribe_data : bribeResource
#@export var bribeTelephone : Resource = load("res://Bribes/telephone.tres")
@export var bribeMetronome : Resource = load("res://Bribes/metronome.tres")
@export var bribeLettre : Resource = load("res://Bribes/lettre.tres")
@export var tableauObjets : Array = []
var loadScene
@export var tableauNarra : Array = []
@export var bribesSection1 : Array = []
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
var col_printed #debug : affiche (une seule fois) quelle bribe déclenche le raycast
var old_bribe
var object_grabbed
var bribes_obtenues = 0
@export var piano = Area3D
signal _on_piano_mouse_entered
signal _on_piano_mouse_exited
signal bribes_S1_all_get
signal bribe_obtenue



func _ready():
	anxieux = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AudioStreamPlayer")
	animation = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
	rayCast = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/RayCast3D")
	text.visible = false 
	#tableau avec toutes les bribes
	tableauObjets = [bribeMetronome, bribeLettre]
	tableauNarra = ["je suis un téléphone dring dring", "je suis un chien bark bark"]
	print (tableauObjets[0])
	for resource in tableauObjets : 
		print ("tableauObjets ressource +1")		
		instance = resource.objetSpriteBroken.instantiate()
		instance.position = resource.emplacement
		instance.bribe_data = resource
		add_child (instance)
	#tout assigner manuellement
	bribesSection1 = [bribeMetronome, bribeLettre]
	#le isActivated va permettre d'activer les bribes en fonction des sections de jeu
	bribeMetronome.isActivated = true
	bribeLettre.isActivated = true
		#instance.grabObject.connect(_on_grab_object)
		#instance.envoiData.connect(_on_envoi_data)
		#resource_data = {"resource": resource} #créer un dictionnaire pour stocker la référence à la resource
		#instance.set_meta("resource_data", resource_data) #stocker le dictionnaire dans l'instance


#func _on_envoi_data(instance2 : bribe_instance):
	#stock_data = instance2.bribe_data

func _physics_process(delta):
	var in_piano
	if rayCast.is_colliding() && !object_grabbed: 
		var collider = rayCast.get_collider()
		if collider == piano: #si le raycast touche le piano, on émet le signal UNE FOIS sinon ça proc ttes les frames
			if !in_piano:
				_on_piano_mouse_entered.emit()
				in_piano = true
				
		else: # si le raycast touche pa le piano, on fait les trucs habituels
			obj_col = collider.get_parent()
			get_resource = obj_col.bribe_data
			if !col_printed: #meilleur debug pour pas avoir 26 000 prints de la bribe qu'on regarde
				print (obj_col.name)
				col_printed = true
			if get_resource.isActivated == true:
				verifCollider = true
				#recupData.emit()
				enableOutline.emit()
		return (get_resource)
		return (obj_col)
	else : 
		in_piano = false
		_on_piano_mouse_exited.emit() #on dit au code qu'on est plus dans le piano si on y était
		col_printed = false
		verifCollider = false
		disableOutline.emit()

func _unhandled_input(event):
	if Input.is_action_just_pressed("left_click") and verifCollider:
		print ("SAUTER DU PONT")
		_on_grab_object()

#func brouillon mental de Poire():
	#le QTE envoie un signal à bribe pour dire quelle section est terminée
	#bribe update un int en fonction du signal
	#on match l'int section
	#ça active les bribes appropriées à chaque section, et désactive les mauvaises

func _on_grab_object(): #instanceBribe : bribe_instance
	#var clicked_instance = collider
	#var resource_data = instance.get_meta("resource_data") #on va chercher les données de la ressource
	#resource_data = instanceBribe.bribe_data
	#if stock_data : 
	object_grabbed = true
	loadScene = get_resource.objetSpriteFixed.instantiate() #on load la version non pété de l'objet
	loadScene.onSelfDestroy.connect(onSpriteFixedDestroyed)
	add_child(loadScene)
	char.activeShader(true)
	animation.play("Anxiety")
	#instanceBribe.queue_free()
	text.text = get_resource.dialogue
	text.visible = true
	obj_col.queue_free() #On supprime l'objet brisé au moment où l'objet fixed est ramassé
	if get_resource in bribesSection1: #on incrémente les bribes ramassées de 1
		bribes_obtenues += 1
		bribe_obtenue.emit() #on envoie le signal pour dire à Appart qu'on a ramassé une bribe
		print (bribes_obtenues)
	_check_bribes_collected()

func _check_bribes_collected():
	print("bribes_obtenues = " + str(bribes_obtenues))
	if bribes_obtenues == 2:
		bribes_S1_all_get.emit() #si on a toutes les bribes, on le dit à Appart
	

		#clicked_instance.queue_free()
		#text.visible = true
		#text.text = resource_data.resource.dialogue
		#for string in tableauNarra :
			#print ("JE VAIS SAUTER")
			
#func _on_enable_outline():
	#outline = true
	#print ("outline visible")
	#for child in get_resource.get_children():
		#if child is MeshInstance3D:
			#for surface in range(0, child.get_surface_override_material_count() ):
				#child.get_surface_override_material(surface).next_pass.set("shader_param/enable", true)
	##$".".get_child(0).get_surface_override_material(0).next_pass.set("shader_param/enable", true)
	#pass # Replace with function body.
	#
#func _on_disable_outline():
	#outline = false 
	#print ("outline invisible")
	#for child in get_resource.get_children():
		#if child is MeshInstance3D:
			#for surface in range(0, child.get_surface_override_material_count() ):
				#child.get_surface_override_material(surface).next_pass.set("shader_param/enable", false)
	#pass # Replace with function body.

func onSpriteFixedDestroyed():
	text.visible = false
	object_grabbed = false #on tient plus rien dans les mains, si on met pas ça le raycast ne marche plus après la première bribe
 
	


