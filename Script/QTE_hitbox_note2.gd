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
var notes2Array
var notes3Array
var notes4Array
signal on_destroy


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
	keyname = str($".".name)
	#area_name = get_node(keyname)
	print(keyname)
	print(typeof(keyname))
	arrayNamesQTE = [ "", "" ,"QTE_note_2", "QTE_note_3", "QTE_note_4"]
	var name2 = arrayNamesQTE[2]
	var name3 = arrayNamesQTE[3]
	var name4 = arrayNamesQTE[4]
	notes2Array = []
	notes3Array = []
	notes4Array = []
	match keyname:
		name2:
			QTE_key = KEY_2
		name3:
			QTE_key = KEY_3
		name4:
			QTE_key = KEY_4
	
	
	
func _on_area_entered(_area):
	#if area is Area3D:
	_qtetimeframe = true
	#qte_in_limit()
	#print("bonsoir")
	
func _on_area_exited(_area):
	_qtetimeframe = false
	pass # Replace with function body.

func _process(delta):
	_slide_down(delta)
	_onQTEspawned()
	pass
#PENSER A STOCKER TOUCHES DANS VARIABLES POUR LA VARIATION FUTURE DES QTE !!!
#single qte (touche qui bouge sur l'écran) = scène et on les instancie depuis celle-ci
#array qui contient les QTE spawnés (triés par note ?)
#on spawn add to array
#on queue free delete dernier index
func _onQTEspawned():
	var current_note
	if !_qtetimeframe && Input.is_key_pressed(QTE_key) && !_qte_reussi && $"." != null: #QTE hors range
		print("C'est raté ! ")
		_qte_reussi = false
		on_destroy.emit()
	elif _qtetimeframe && Input.is_key_pressed(QTE_key) && !_qte_reussi:
		score += 1
		print("C'est réussi ! Score : ", score)
		_qte_reussi = true
		_qtetimeframe = false
		on_destroy.emit()
		pass
	
func _slide_down(delta):
	if moving:
		$".".position = $".".position.move_toward(destination_position, delta*move_speed)
	if $".".position == destination_position:
		moving = false
		
		print("missed!")
