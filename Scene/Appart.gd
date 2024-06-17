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
@export var current_section : int
signal check_section_bribe
signal QTE_on_wake #marche
@export var character : PackedScene
@export var scene_QTE : PackedScene
var character_instance


func ready(): #j'adore connecter des signaux
	piano._on_piano_mouse_entered.connect(_on_piano_raycast)
	piano._on_piano_mouse_exited.connect(_on_piano_raycast_out)
	bribe.bribes_S1_all_get.connect(_status_bribes)
	bribe.bribe_obtenue.connect(_piano_notes_UI)
	$AudioStreamPlayer.play()
	
func _status_bribes():
	bribes1 = true
	print("on a toutes les bribes : " + str(bribes1))
	current_section = 1 
	$Animation_Notes_Piano.play("piano_notes_ui_jump") #petite animation de feedback sur le piano

func _process(delta):
	##debut porte de l'appart
	#$AnimationPlayer.play("Note mouving")
	##if Tuto == true:
	##_ouvrir_bureau()
	pass

func _on_piano_raycast():
	mouse_in_piano = true
	
func _on_piano_raycast_out():
	mouse_in_piano = false

func _piano_notes_UI(): #compter les bribes récoltées actualise l'UI du piano
		UIbribe +=1
		_UiUpdate()
	
func _input(event):
	var old_char = $Bribe.char
	var new_pos = $Scene_QTE_spawn/qte_origin.position
	#mouse_in_piano = est-ce que le raycast est dans le piano, bribes1 = est-ce qu'on a toutes les bribes de la section 1
	if event is InputEventMouseButton && event.is_action_pressed("left_click") && mouse_in_piano == true && bribes1 == true: 
			if old_char != null:
				old_char.queue_free() #on vire l'ancien char
			character_instance = character.instantiate() #spawn un nouveau char 
			$".".add_child(character_instance) #on le met en enfant de appart et pas bribe le démon
			#on ré-initialise les variables de Bribe liées au char sinon il est paumé
			$Bribe.textes_intrusif = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/texteIntrusif/Texte_intrusif")
			$Bribe.start_anxiete = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
			$Bribe.anxieux_QTE = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/inputA")
			$Bribe.animation = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/CanvasLayer/AnimationPlayer")
			$Bribe.rayCast = character_instance.get_node("CharacterBody3D/Rotation_Helper/Camera3D/RayCast3D")
			character_instance.position = new_pos #on reset l'offset du character
			character_instance.position = $Scene_QTE_spawn.position #on le met à l'emplacement de la scène QTE
			character_instance.can_move = false #on lui dit assis toutou
			$AudioStreamPlayer.stop()
			QTE_on_wake.emit() #vrmt g juré mtnt ca marche la vie est belle
			
			

func _appart_qte_finished(): #appelee depuis QTE quand on a fini un QTE
	print("current_section = " + str(current_section))
	var axis = Vector3(0, 1, 0).normalized()
	var rotation_angle = deg_to_rad(90)
	character_instance.position = $Piano_spawn.position
	character_instance.can_move = true #on ramène le char devant le piano
	match current_section: #on est dans quelle section ? On ouvre les bonnes bortes et dit à bribe d'activer les bonnes bribes
		2:
			check_section_bribe.emit()
			$Porte_Cuisine.rotate(axis, rotation_angle)
		3:
			check_section_bribe.emit()
			$Porte_SDB.rotate(axis, rotation_angle)
		4:
			check_section_bribe.emit()
			$Porte_Chambre.rotate(axis, rotation_angle)
		5:
			check_section_bribe.emit()
			#tp dans la ballroom
	pass # Replace with function body.


func _UiUpdate():
	if UIbribe == 1:
		$UI_Bribe2.hide()
		$UpdatedSprite2.show()
		$Animation_Notes_Piano.play("piano_notes_ui_jump")
		var axis = Vector3(0, 1, 0).normalized()
		var rotation_angle = deg_to_rad(90)
		Porte.rotate(axis, rotation_angle)
	if UIbribe == 2:
		$UI_Bribe.hide()
		$UpdatedSprite1.show()


