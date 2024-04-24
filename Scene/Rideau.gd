extends Area3D
@export var Texte: Label
@export var meuble: CollisionShape3D
@export var Narration: String

var textes_objets = {
	"Rideau": "Le soleil ? Non merci, je m’en passerais.",
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
