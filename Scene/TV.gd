extends Area3D
@export var Texte: Label
@export var meuble: CollisionShape3D
@export var Narration: String

var textes_objets = {
	"TV": "Heureusement que cette TV a choisi le silence d’elle-même. \n Ma mère devrait suivre son exemple.",
}


func _on_mouse_entered():
	print("jsusidanslazone")
	for i in textes_objets:
		print("aled aled")
		Texte.text = textes_objets[Narration]
		
func _on_mouse_exited():
	Texte.hide()
