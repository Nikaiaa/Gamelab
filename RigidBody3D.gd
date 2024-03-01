extends RigidBody3D

var score = 0
var maxScore = 10
func _ready():
	$"../QTE/AnimationPlayer".play("Slid")

func _on_rigid_body_qte_3d_body_entered(body):
	if body is RigidBody3D:
		print("Appuie sur A !!")

		if Input.is_key_pressed(KEY_A):
			score += 1
			print("C'est juste ! Score : ", score)

func _on_rigid_body_qte_3d_body_exited(body):
	if !Input.is_key_pressed(KEY_A) and body is RigidBody3D:
		print("Raté! Score : ", score)

	

			#if score >= maxScore:
			  
				#playMusic()  # Définissez cette fonction pour jouer votre musique
			   #queue_free()  # Quittez la scène ou effectuez d'autres actions nécessaires
