extends Node3D

#instance de la note et scène de la note preloadée
var note_instance
@export var Note : PackedScene

#arrays pour chaque type de note. En rajouter 1 par futur type
@export var notes2Array = []
@export var notes3Array = []
@export var notes4Array = []

#Array des CompressedTexture2D aka sprites des notes. A tenir à jour avec ts les nouveaux sprites
@export var arrayTextures : Array[CompressedTexture2D]

#Array contenant les positions de spawn des notes
@export var arrayStartPos : Array[Node3D]
@export var timer2 : Timer
@export var timer3 : Timer
@export var timer4 : Timer
@export var finQTE : VideoStreamPlayer
@export var appart : Node3D
signal QTE_finished

#Les timer sont responsables du spawn des notes 
#_spawn_note prend un int "note" en argument : ceci servivra à déterminer quel type de QTE spawne
func _on_timer_spawn_note_2_timeout():
	_spawn_note(2)
	#
func _on_timer_spawn_note_3_timeout():
	_spawn_note(3)
#
func _on_timer_spawn_note_4_timeout():
	_spawn_note(4)  


func _ready(): #L'idee c'etait de check dans quelle section on est au lancement de la scene QTE, mais à chaque changement de scene les variables sont reset
	finQTE = $Control/VideoStreamPlayer
	#On peut manipuler les timer pour spawner les notes selon des patterns réguliers
	#timer2.start(0.8)
	#timer3.start(1)
	#timer4.start(3)x
	pass
	
func _section_check(): #match pour jouer la bonne pattern dans la bonne section 
	var section = appart.current_section
	print("section = " + str(section)) #tjrs 0
	match section:
		1:
			$MusiqueAP.play("Section_1")
			$Timer/AudioStreamPlayer.play()
			pass
		#2:
			#pass
		#3:
			#pass
		#4:
			#pass
		#5:
			#pass

func _spawn_note(note : int): 
	note_instance = Note.instantiate() 
	#On connecte le signal end_of_course de l'instance de QTE à la méthode end of course dans CE SCRIPT(l.82)
	note_instance.end_of_course.connect(_end_of_course) #instance.signal.connect(nom_méthode_locale)
	#On lui donne l'apparence correspondante via la méthode assign_texture de l'instance de QTE
	note_instance.assign_texture(arrayTextures[note])
	note_instance.position = arrayStartPos[note].position #setup start position
	add_child(note_instance)
	note_instance.noteName = str(note)
	match note: #On met les notes spawnées dans les array correspondants en fonction de l'int donné en paramètre
		2:
			notes2Array.append(note_instance)
		3:
			notes3Array.append(note_instance)
		4:
			notes4Array.append(note_instance)

func _process(_delta):
	_checkinput()

func _checkinput():
	var noteChecked #note vérifiée actuellement
	if Input.is_action_just_pressed("press_key_2") && notes2Array.size() > 0: 
		#Ici future condition pour checker "is key released" -> note tenue 
		noteChecked = notes2Array.front()
		notes2Array.remove_at(0)
	if Input.is_action_just_pressed("press_key_3") && notes3Array.size() > 0:
		noteChecked = notes3Array.front()
		notes3Array.remove_at(0)
	if Input.is_action_just_pressed("press_key_4") && notes4Array.size() > 0:
		noteChecked = notes4Array.front()
		notes4Array.remove_at(0)
	if not noteChecked: #default/null
		return 
	match noteChecked.myetat: #on check l'état (déclaré dans QTE_note)
		QTE.etat.rate:
			print(noteChecked.noteName + " est ratée")
			noteChecked._play_animation_missed()
		QTE.etat.reussi:
			print (noteChecked.noteName + " est réussie")
			noteChecked._play_animation_reussi()
		QTE.etat.missed:	
			print (noteChecked.noteName + " missed")
			noteChecked._play_animation_missed()
	print("_______")
	#noteChecked.destroy()
	
func _end_of_course(note : QTE): #Trigger quand l'objet de classe QTE arrive au bout de son parcours 
	#(Destination_position dans QTE_Note)
	match note.noteName: #On supprime la bonne note en fonction de son nom
		"2":
			notes2Array.erase(note) #On erase dans le tableau d'abord
			#note.destroy() #On détruit le node ensuite
		"3":
			notes3Array.erase(note)
			#note.destroy()
		"4":
			notes4Array.erase(note)
			#note.destroy()
	note._play_animation_missed()
	print (note.noteName + " missed")
	print("_______")

func _avance():
	finQTE.play()
func _end_of_QTE():
	appart.current_section += 1 #ici en cas de réussite on incrémente la section de 1 (mm si ça sert à rien du coup mdr)
	QTE_finished.emit() #signal pour renvoyer vers Appart 

	
