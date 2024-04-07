extends Area3D
@export var Texte: Label
@export var meuble: CollisionShape3D
@export var Narration: String

var textes_objets = {
	"Cadre": "Il faut toujours avoir un ou deux noms d'oiseaux sous la main. Self-defense",
	"Rideau": "Le soleil ? Non, je m'en passerais.",
	"TV": "De toute façon je me serais occupé de son cas si elle n'avait pas rendu l'âme la première",
	"Plantes": "La vie ne peut pas germer avec toi Charlie.. toujours à avoir le dernier mot.",
	"Guitare": "Je n'ai jamais eu le temps d'apprendre de la guitare... Et maintenant je déborde de temps mais l'envie me fuit",
	"Piano": "Le piano de papa... Je me demande ce que mon père dirait si il me voyait en ce moment...",
	"Frigo": "Je n'en peux plus de gâcher de la nourriture.. Mais je n'ai plus la foi de cuisiner",
	"Brosse": "Je suis content d'avoir pu récupérer ses affaires. Qui sait ce que sa famille en aurait fait après avoir appris..",
	"Canard": "Quand la vie veut nous faire rouler, il faut savoir flotter... et rester iconique, ouinc",
	"Talons": "Conseil à tout les jeunes drag : ne vous entrainez pas à marcher en talon près d'une étagère bon marché...",
	"Etagère": "Les conséquences de l'apprentissage..Pardon pour l'étagère, David."
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
