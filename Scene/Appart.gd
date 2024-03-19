extends Node3D

#En gros chaque porte va avoir sa propriete pour s'ouvrir
var Tuto = false
var QTE1 = false
var QTE2 = false
var QTE3 = false
var QTE4 = false
var Porte 

func _ouvrir_bureau():
	if $Porte_bureau != null:
		Porte = $Porte_bureau
		Porte.rotate(Vector3(0, 90, 0))

func _process(delta):
	#debut porte de l'appart
	if Tuto == true:
		_ouvrir_bureau()
