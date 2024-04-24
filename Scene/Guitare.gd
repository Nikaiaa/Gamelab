extends Area3D
@export var Texte: Label
@export var meuble: CollisionShape3D
@export var Narration: String

var textes_objets = {
	"Guitare": "Je n’ai jamais eu le temps d’apprendre la guitare avec David… \n Mais maintenant je déborde de temps et l’envie me fuit.",
}


func _on_mouse_entered():
	print("jsusidanslazone")
	for i in textes_objets:
		print("aled aled")
		#Texte.text = textes_objets[TABLEAUDETAMERE[meuble].name]
		Texte.text = textes_objets[Narration]
		
		print(Texte)
		
func _on_mouse_exited():
	Texte.hide()
