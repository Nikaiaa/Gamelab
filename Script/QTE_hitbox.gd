extends Node3D

var score = 0
var maxScore = 10
var qtetimeframe
var qte_status
var qte_reussi

#qte status
#appuyé trop tot : miss
#appuyé dans la limite : success
#appuyé après la limite : miss

func _ready():
	$"CollisionShape3D/Sprite3D/AnimationPlayer".play("QTE_slide_down")
	qtetimeframe = false
	qte_reussi = false
	
func _on_area_entered(area):
	#if area is Area3D:
	qtetimeframe = true
	#qte_in_limit()
	#print("bonsoir")
	
func _on_area_exited(area):
	qtetimeframe = false
	pass # Replace with function body.

func _process(_delta):
	_onQTEspawned()
	pass
#func _on_rigid_body_qte_3d_body_entered(body):
	#print("bonsoir")
	#if body is RigidBody3D:
		#print("Appuie sur A !!")
#
		#if Input.is_key_pressed(KEY_A):
			#score += 1
			#print("C'est juste ! Score : ", score)
#
#func _on_rigid_body_qte_3d_body_exited(body):
	#print("bonsoir!!")
	#if !Input.is_key_pressed(KEY_A) and body is RigidBody3D:
		#print("Raté! Score : ", score)

#func qte_in_limit():
	#while qte_reussi == false:
		#if Input.is_key_pressed(KEY_A) && qtetimeframe:
			#score += 1
			#print("C'est juste ! Score : ", score)
			#qte_reussi = true
	#pass # Replace with function body.
	
#PENSER A STOCKER TOUCHES DANS VARIABLES POUR LA VARIATION FUTURE DES QTE !!!
#single qte (touche qui bouge sur l'écran) = scène et on les instancie depuis celle-ci
func _onQTEspawned():
	if !qtetimeframe && Input.is_key_pressed(KEY_A) && !qte_reussi && $"../AreaQTE" != null: #QTE hors range
		print("C'est raté ! ")
		qte_reussi = false
		$"../AreaQTE".queue_free()
	elif qtetimeframe && Input.is_key_pressed(KEY_A) && !qte_reussi:
		score += 1
		print("C'est réussi ! Score : ", score)
		qte_reussi = true
		qtetimeframe = false
		$"../AreaQTE".queue_free()
	pass

			#if score >= maxScore:
			  
				#playMusic()  # Définissez cette fonction pour jouer votre musique
			   #queue_free()  # Quittez la scène ou effectuez d'autres actions nécessaires




