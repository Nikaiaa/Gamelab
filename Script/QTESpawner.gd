#extends Node3D
#
#var score = 0
#var maxScore = 10
#var _qtetimeframe
#var _qte_reussi
#var _qtealive
#var Note2 = preload("res://Scene/QTE_note_2.tscn")
#var Note3 = preload("res://Scene/QTE_note_3.tscn")
#var Note4 = preload("res://Scene/QTE_note_4.tscn")
#var note2_instance
#var note3_instance
#var note4_instance
#var timer2
#var timer3
#var timer4
#@export var notes2Array = []
#@export var notes3Array = []
#@export var notes4Array = []
#var keyname
#var arrayNamesQTE
#var QTE_key
#
#func _ready():
#
	#timer2 = $AreaLimite/TimerSpawnNote2
	#timer3 = $AreaLimite/TimerSpawnNote3
	#timer4 = $AreaLimite/TimerSpawnNote4
	#timer2.start(0.8)
	##timer3.start(1)
	##timer4.start(3)
	#_qtetimeframe = false
#
	#
##Les timer sont responsables du spawn des notes 
#func _on_timer_spawn_note_2_timeout():
	#_spawn_note_2()
	#pass # Replace with function body.
	#
#func _on_timer_spawn_note_3_timeout():
	#_spawn_note_3()
	#pass # Replace with function body.
#
#func _on_timer_spawn_note_4_timeout():
	#_spawn_note_4()  
	#pass # Replace with function body.
#
##Pour l'instant seules les notes de type 2 spawnent. PLus tard le code fonctionnera avec des notes de différents types instanciées en simultané
#func _spawn_note_2():
	#note2_instance = Note2.instantiate() 
	#note2_instance.position = $SPN2.position #setup start position
	#add_child(note2_instance)
	#notes2Array.append(note2_instance) #on la met dans son array correspondant
	#note2_instance.name = str("Note_2" + str(notes2Array.size())) #on set le node name pour plus tard
	#print("notes2array size = "+ str(notes2Array.size()))
	#_chose_name()
	#_qtealive = true
	#_qtetimeframe = false
#
#
#func _spawn_note_3():
	#note3_instance = Note3.instantiate()
	#note3_instance.position = $SPN3.position
	#add_child(note3_instance)
	##notes3Array.append(note3_instance)
	#
#func _spawn_note_4():
	#note4_instance = Note4.instantiate() 
	#note4_instance.position = $SPN4.position
	#add_child(note4_instance)
	##notes4Array.append(note4_instance)
	#
##Ici on va choisir et assigner quelle touche doit être pressée pour que le QTE fonctionne 
#func _chose_name():
	#var string  = ""
	#keyname = str(note2_instance.name)
	#print("keyname = " + str(keyname))
	#print("typeof keyname =" + str(typeof(keyname)))
	#print("___")
	#arrayNamesQTE = [ "", "" ,"Note_2", "Note_3", "Note_4"]
	#var name2 = arrayNamesQTE[2]
	#var name3 = arrayNamesQTE[3]
	#var name4 = arrayNamesQTE[4]
	#if "Note_2" in keyname: #redondant avec le match, on testera plus tard pour savoir quelle méthode sera la + efficace
		#QTE_key = KEY_2
	#match string in keyname: #match expérimental pas sur que ça marche, à tester quand ça buggera plus
		#"Note2":
			#QTE_key = KEY_2
			##print (str(QTE_key) + "assignée !")
			####notes2Array.append($".")
		#"Note3":
			#QTE_key = KEY_3
			####notes3Array.append($".")
		#"Note4":
			#QTE_key = KEY_4
			####notes4Array.append($".")
			#
#func _process(_delta):
	#if notes2Array.size()>0:
		#_onQTEspawned()
	#pass
#
#func _onQTEspawned(): #gestion du statut réussi/échoué du QTE
	#_delete_empty() #on clear les array  des instances nulles par précaution
	#if Input.is_key_pressed(QTE_key) && _qtealive: 
		#if !_qtetimeframe:#QTE hors range
			#print ("qtetimeframe =" + str(_qtetimeframe))
			#print("C'est raté ! ")
			#_delete_empty()
			#notes2Array.front().queue_free() #erase le qte le + ancien 
			#_qtetimeframe = false
			#_qtealive = false
			#print("_________")
		#elif _qtetimeframe: #QTE in range 
			#score += 1 
			#print ("qtetimeframe =" + str(_qtetimeframe))
			#print("C'est réussi ! Score : ", score)
			#print("_________")
			#_delete_empty()
			#notes2Array.front().queue_free() #erase le qte le + ancien 
			##_qte_reussi = true
			#_qtetimeframe = false
			#_qtealive = false
#
#
#
#func _on_area_limite_area_entered(_area):
	#_qtetimeframe = true
	#pass # Replace with function body.
	#
#func _on_area_limite_area_exited(_area):
	#_qtetimeframe = false
	#pass # Replace with function body.
#
#func _delete_empty():
	#for object in notes2Array:
		#if object == null:
			#notes2Array.erase(object)
#
##func killnote():
	###print(str(keyname))
	##if "Note_2" in keyname:
		##notes2Array.back().queue_free()
