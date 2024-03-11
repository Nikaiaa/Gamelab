extends Node3D

var score = 0
var maxScore = 10
var _qtetimeframe
var _qte_reussi
var arrayNamesQTE
var QTE_key
var keyname
var move_speed
var moving
var destination_position

#@export var notes2Array = []
#@export var notes3Array = []
#@export var notes4Array = []



#qte status
#appuyé trop tot : miss
#appuyé dans la limite : success
#appuyé après la limite : miss

func _ready():
	#$"CollisionShape3D/Sprite3D/AnimationPlayer".play("QTE_slide_down")
	move_speed = 10
	moving = true
	destination_position = $CollisionShape3D/Destination_Position.position
	
	_qtetimeframe = false
	_qte_reussi = false
	#_chose_name()

	
#func _on_area_entered(_area):
	#_qtetimeframe = true
	#
#func _on_area_exited(_area):
	#_qtetimeframe = false
	#pass # Replace with function body.

#func _chose_name():
	#notes2Array.push_front($"..")
	#print("notes2array size = "+ str(notes2Array.size()) )
	#keyname = str($".".name)
	#print(keyname)
	#print(typeof(keyname))
	#arrayNamesQTE = [ "", "" ,"QTE_note_2", "QTE_note_3", "QTE_note_4"]
	#var name2 = arrayNamesQTE[2]
	#var name3 = arrayNamesQTE[3]
	#var name4 = arrayNamesQTE[4]
	#match keyname:
		#name2:
			#QTE_key = KEY_2
			###notes2Array.append($".")
		#name3:
			#QTE_key = KEY_3
			###notes3Array.append($".")
		#name4:
			#QTE_key = KEY_4
			###notes4Array.append($".")
	

func _process(delta):
	_slide_down(delta)
	#if notes2Array.size() < 1:	
	#_onQTEspawned()
	#elif notes2Array.size() >=1:
		#notes2Array.back()._onQTEspawned()


#PENSER A STOCKER TOUCHES DANS VARIABLES POUR LA VARIATION FUTURE DES QTE !!!
#single qte (touche qui bouge sur l'écran) = scène et on les instancie depuis celle-ci
#array qui contient les QTE spawnés (triés par note ?)
#on spawn add to array
#on queue free delete dernier index
#func _onQTEspawned():
	#if !_qtetimeframe && Input.is_key_pressed(QTE_key) && !_qte_reussi && $"." != null: #QTE hors range
		#print("C'est raté ! ")
		#_qte_reussi = false
		
		##if !qtedeleted:
			##notes2Array.back().queue_free()
			##qtedeleted = true
		##match QTE_key:
			##KEY_2:
				##current_note = notes2Array.back()
				##current_note.queue_free()
			##KEY_3:
				##current_note = notes3Array.back()
				##current_note.queue_free()
			##KEY_4:
				##current_note = notes4Array.back()
				##current_note.queue_free()
		#
	#elif _qtetimeframe && Input.is_key_pressed(QTE_key) && !_qte_reussi:
		#score += 1
		#print("C'est réussi ! Score : ", score)
		#_qte_reussi = true
		#_qtetimeframe = false
		##if !qtedeleted:
			##notes2Array.back().queue_free()
			##qtedeleted = true
		##match QTE_key:
			##KEY_2:
				##current_note = notes2Array.back()
				##notes2Array.pop_back()
				##current_note.queue_free()
			##KEY_3:
				##current_note = notes3Array.back()
				##notes3Array.pop_back()
				##current_note.queue_free()
			##KEY_4:
				##current_note = notes4Array.back()
				##notes4Array.pop_back()
				##current_note.queue_free()
		#pass
	
func _slide_down(delta):
	if moving:
		$".".position = $".".position.move_toward(destination_position, delta*move_speed)
	if $".".position == destination_position:
		moving = false
		$"..".queue_free()
		print("missed!")
		print("_______")
		
#func _bordel():
	##func _on_rigid_body_qte_3d_body_entered(body):
		##print("bonsoir")
		##if body is RigidBody3D:
			##print("Appuie sur A !!")
	##
			##if Input.is_key_pressed(KEY_A):
				##score += 1
				##print("C'est juste ! Score : ", score)
	##func _on_rigid_body_qte_3d_body_exited(body):
		##print("bonsoir!!")
		##if !Input.is_key_pressed(KEY_A) and body is RigidBody3D:
			##print("Raté! Score : ", score)
	##func qte_in_limit():
		##while qte_reussi == false:
			##if Input.is_key_pressed(KEY_A) && qtetimeframe:
				##score += 1
				##print("C'est juste ! Score : ", score)
				##qte_reussi = true
		##pass # Replace with function body.
	##if score >= maxScore:
		##playMusic()  # Définissez cette fonction pour jouer votre musique
		##queue_free()  # Quittez la scène ou effectuez d'autres actions nécessaires
#pass


