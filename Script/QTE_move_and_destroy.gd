extends Node3D

class_name QTE #QTE est une classe

signal end_of_course (me : QTE) #signal propre à la classe QTE. Emis quand le QTE atteint son point de destination

var move_speed
var moving

@export var destination : Node3D
@export var apparence : Sprite3D

enum etat {rate, reussi, missed}
@export var myetat : etat = etat.rate

var noteName : String

@export var Note : Area3D

#cette fonction sera appelée dans le QTEManager de la scène QTE. 
#Les variables de texture (sprites des QTE) sont stockées dans un array généré dans la scène du QTEManager
#L'argument "text" est la texture que l'on va assigner à notre note au spawn
func assign_texture(text):
	if not text: #debug si y a pas de texture
		print("no_texture_found")
	apparence.texture = text #Apparence est un Sprite3D. On lui assigne la texture "text",
	#(qui sera choisie dans le QTEManager)

func _ready():
	move_speed = 10
	moving = true
	
func _process(delta):
	_slide_down(delta)

func _slide_down(delta): #mouvement du QTE. Possibilité d'utiliser un animationplayer ! 
	if moving: 
		#la position du QTE se rapproche de celle de destination_position
		Note.position = Note.position.move_toward(destination.position, delta*move_speed) 
	if Note.position == destination.position: #Si le QTE est arrivé, on le stoppe et on émet le signal pour le détruire
		moving = false
		end_of_course.emit(self)

func _on_qte_note_area_entered(area): #On est dans la zone de réussite
	myetat = etat.reussi
	pass # Replace with function body.

func _on_qte_note_area_exited(area): #On est sorti de la zone de réussite
	myetat = etat.missed
	pass # Replace with function body.
	
#Fonction appelée dans QTEManager.
func destroy():  
	#On mettra ici tout ce qui est comportement et polish lorsque la note est détruite
	queue_free()
