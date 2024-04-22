extends Node3D

#En gros chaque porte va avoir sa propriete pour s'ouvrir
var Tuto = false
#var QTE1 = false
#var QTE2 = false
#var QTE3 = false
#var QTE4 = false
var qte: PackedScene
var mouse_in_piano
var UIbribe = 0
@onready var Porte = $Porte_bureau
@export var piano = Area3D 
@export var bribe = Node3D
var piano_on = false
var bribes1
var current_section
signal QTE_on_wake #marche pas
@export var character : PackedScene

func ready(): #j'adore connecter des signaux
	piano._on_piano_mouse_entered.connect(_on_piano_raycast)
	piano._on_piano_mouse_exited.connect(_on_piano_raycast_out)
	bribe.bribes_S1_all_get.connect(_status_bribes)
	bribe.bribe_obtenue.connect(_piano_notes_UI)
	
func _status_bribes():
	bribes1 = true
	print("on a toutes les bribes : " + str(bribes1))
	current_section = 1 #ça ça marche pa
	$Animation_Notes_Piano.play("piano_notes_ui_jump") #petite animation de feedback sur le piano

func _process(delta):
	##debut porte de l'appart
	#$AnimationPlayer.play("Note mouving")
	$Animation_note_bribe.play("Just_moving")
	##if Tuto == true:
	##_ouvrir_bureau()

func _on_piano_raycast():
	mouse_in_piano = true
	
func _on_piano_raycast_out():
	mouse_in_piano = false

func _piano_notes_UI(): #compter les bribes récoltées actualise l'UI du piano
		UIbribe +=1
		_UiUpdate()
	

func _unhandled_input(event):
	var new_pos = Vector3(0,1,0)
	var character_instance
	var old_char = $Bribe.char
	#mouse_in_piano = est-ce que le raycast est dans le piano, bribes1 = est-ce qu'on a toutes les bribes de la section 1
	if event is InputEventMouseButton && event.is_action_pressed("left_click") && mouse_in_piano == true && bribes1 == true: 
			
			#TENTATIVE DE TELEPORTATION DU PERSONNAGE JOUABLE
			#POUR RETABLIR LES QTE DECOMMENTER L'AVANT DERNIERE LIGNE ET COMMENTER TOUT LE RESTE
			
			#old_char.queue_free() #on vire l'ancien char
			#$Bribe.position = new_pos #on set la position de bribe comme référentiel (pourra être n'importe quel node au final) 
			#character_instance = character.instantiate() #spawn un nouveau char (aled)
			#$Bribe.add_child(character_instance) #on le met en enfant de bribe 
			##on ré-instancie les variables de Bribe liées au char sinon il est paumé
			#$Bribe.anxieux = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AudioStreamPlayer")
			#$Bribe.animation = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
			#$Bribe.rayCast = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/RayCast3D")
			#character_instance.position = new_pos #on set la position (future position de la scène qte)
			get_tree().change_scene_to_file("res://Scene/QTE.tscn")
			#QTE_on_wake.emit() #vrmt g juré ça marche pas
			
			

func _UiUpdate():
	if UIbribe == 1:
		$UI_Bribe.hide()
		$UpdatedSprite1.show()
		var axis = Vector3(0, 1, 0).normalized()
		var rotation_angle = deg_to_rad(90)
		Porte.rotate(axis, rotation_angle)
	if UIbribe == 2:
		$UI_Bribe2.hide()
		$UpdatedSprite2.show()
