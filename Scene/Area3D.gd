extends Area3D

var textes_objets = {
	$Cadre: "Il faut toujours avoir un ou deux noms d'oiseaux sous la main. Self-defense",
	#"Rideau": "Le soleil ? Non, je m'en passerais.",
	#"TV": "...(ne fonctionne plus)",
	#"Plantes": "La vie ne peut pas germer avec toi Charlie.. toujours à avoir le dernier mot.",
	#"Guitare": "Je n'ai jamais eu le temps d'apprendre de la guitare... Et maintenant je déborde de temps mais l'envie me fuit",
	#"Piano": "Le piano de papa..Je ne sais pas si je me sens prêt à m'asseoir à nouveau.",
	#"Frigo": "Je n'en peux plus de gâcher de la nourriture.. Mais je n'ai plus la foi de cuisiner",
	#"Brosse": "Je suis content d'avoir pu récupérer ses affaires. Qui sait ce que sa famille en aurait fait après avoir appris..",
	#"Canard": "Quand la vie veut nous faire rouler, il faut savoir flotter... et rester iconique, ouinc",
	#"Talons": "Conseil à tout les jeunes drag : ne vous entrainez pas à marcher en talon près d'une étagère bon marché...",
	#"Etagère": "Les conséquences de l'apprentissage..Pardon pour l'étagère, David."
}

var label : Label

func _ready():
	label = $Label

func _on_mouse_entered():
	print("jsusidanslazone")
	var nom_objet = name
	if nom_objet in textes_objets:
		label.text = textes_objets[nom_objet]
		print(nom_objet)
