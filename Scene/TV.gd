extends Area3D
@export var Texte: Label
@export var meuble: CollisionShape3D
@export var Narration: String

var textes_objets = {
	"TV": "...(ne fonctionne plus)",
}


func _on_mouse_entered():
	print("jsusidanslazone")
	for i in textes_objets:
		print("aled aled")
		Texte.text = textes_objets[Narration]
		
