extends Area3D
@export var Texte: Label
@export var meuble: CollisionShape3D
@export var Narration: String

var textes_objets = {
	"Cadre": "J’aimerais tellement que tu comprennes que tout ceci est ce qu’il y a de mieux pour moi. \n Si papa avait été là, peut-être qu’il m’aurait écouté…",
}


func _on_mouse_entered():
	Texte.show()
	print("zone narra")
	for i in textes_objets:
		print("texte narra")
		#Texte.text = textes_objets[TABLEAUDETAMERE[meuble].name]
		Texte.text = textes_objets[Narration]
		
		print(Texte)


func _on_mouse_exited():
	Texte.hide()
