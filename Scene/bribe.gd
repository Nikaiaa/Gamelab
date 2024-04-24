extends Node

@export var bribe_data : bribeResource
#@export var bribeTelephone : Resource = load("res://Bribes/telephone.tres")
@export var bribeMetronome : Resource = load("res://Bribes/metronome.tres")
@export var bribeLettre : Resource = load("res://Bribes/lettre.tres")
@export var bribeCahierDavid : Resource = load("res://Bribes/cahierDavid.tres")
@export var allBribesArray : Array = []
@export var bribesSection1 : Array = []
@export var bribesSection2 : Array = []
@export var bribesSection3 : Array = []
@export var bribesSection4 : Array = []
@export var bribesSection5 : Array = []

var loadScene

@export var text : Label
var resource_data  #: Dictionary = {}
@onready var char 
var animation
var anxieux_QTE : VideoStreamPlayer
var start_anxiete
var textes_intrusif
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
var verifBribe = false 
var collider
var texte_non_bribe = false
var lastCollider = null


func _ready():
	char = $char
	#$AnimationPlayer.play ("just_moving")
	#QTE_anxiete = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/VideoStreamPlayer")
	textes_intrusif = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/CanvasLayer/Texte_intrusif")
	start_anxiete = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
	#anxieux_QTE = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/VideoStreamPlayer")
	animation = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer2")
	rayCast = char.get_node("CharacterBody3D/Rotation_Helper/Camera3D/RayCast3D")
	text.visible = false 
	
	#tableau avec toutes les bribes
	allBribesArray = [bribeMetronome, bribeLettre, bribeCahierDavid]
	for resource in allBribesArray : 
		print ("allBribesArray ressource +1")
		instance = resource.objetSpriteBroken.instantiate()
		instance.position = resource.emplacement
		instance.bribe_data = resource
		add_child (instance)
		
	#tout assigner manuellement
	bribesSection1 = [bribeMetronome, bribeLettre]
	bribesSection2 = [bribeCahierDavid]
	$"..".current_section = 1
	_bribe_activator()
	#le isActivated va permettre d'activer les bribes en fonction des sections de jeu

func _bribe_activator():
	print("appart section =" + str($"..".current_section))
	for bribe in allBribesArray: #on les passe ttes en false au début pour éviter que d'autres restent true ou qu'il y ait des bribes null après supression qui cassent le code
		if bribe != null:
			bribe.isActivated = false
	match $"..".current_section:
		1:
			for bribe in bribesSection1:
				bribe.isActivated = true
		2:
			for bribe in bribesSection2:
				bribe.isActivated = true
		3:
			for bribe in bribesSection3:
				bribe.isActivated = true
		4:
			for bribe in bribesSection4:
				bribe.isActivated = true
		5:
			for bribe in bribesSection5:
				bribe.isActivated = true
	pass # Replace with function body.


func _physics_process(delta):
	var in_piano
	if rayCast.is_colliding() && !object_grabbed && not rayCast.get_collider().collision_layer == 1 && (rayCast.get_collider() == lastCollider or lastCollider ==  null):
		collider = rayCast.get_collider()
		lastCollider = collider 
		#if (collider as CollisionObject3D).collision_layer == 1:
			#returns
		
		if collider == piano: #si le raycast touche le piano, on émet le signal UNE FOIS sinon ça proc ttes les frames
			if !in_piano:
				_on_piano_mouse_entered.emit()
				in_piano = true
				
		else: # si le raycast touche pa le piano, on fait les trucs habituels
			if collider.is_in_group("nonbribe"): #on vérifie si l'objet détecté est une non bribe
				texte_non_bribe = true 
				#var label = collider.get_node("Label") 
				if collider.Texte:
					var textes_objets = collider.textes_objets
					var Narration = collider.Narration
					collider.Texte.show()
					collider.Texte.text = textes_objets[Narration]
				
		
			elif !(collider as CollisionObject3D).collision_layer == 1:
				obj_col = collider.get_parent()
				get_resource = obj_col.bribe_data
				verifBribe = true #pour être sur que les fonctions liées au bribe ne se déclenchent que si c'en est
			
			if !col_printed and verifBribe: #meilleur debug pour pas avoir 26 000 prints de la bribe qu'on regarde
				print (obj_col.name)
				col_printed = true
				
			if get_resource and verifBribe:
				if get_resource.isActivated == true: #on dit au char de lancer l'anxiété sur les bribes
					char.activeShader(true)
					start_anxiete.play("Start_Anxiete")
					textes_intrusif.play("Pensees_Intrusives_1")
					#anxieux_QTE.play()
					verifCollider = true
					#recupData.emit()
					enableOutline.emit()
		return (get_resource)
		return (obj_col)
	else : 
		lastCollider = null
		if texte_non_bribe == true:
			print ("AAAAAAAAAAAAAAAAAAAAA")
			collider.Texte.hide()
			texte_non_bribe = false
		if char != null: #si y a un char on arrête l'anxiété si on regarde pas une bribe
			start_anxiete.stop()
			#anxieux_QTE.stop()
			textes_intrusif.stop()
			char.activeShader(false)
		in_piano = false
		_on_piano_mouse_exited.emit() #on dit au code qu'on est plus dans le piano si on y était
		col_printed = false
		verifCollider = false
		disableOutline.emit()
		verifBribe = false

func _input(event):
	if Input.is_action_just_pressed("left_click") && verifCollider == true:
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
 
	




