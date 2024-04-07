extends Node3D

#En gros chaque porte va avoir sa propriete pour s'ouvrir
var Tuto = false
#var QTE1 = false
#var QTE2 = false
#var QTE3 = false
#var QTE4 = false
var qte: PackedScene
var jouer = false
var UIbribe = 0
@onready var Porte = $Porte_bureau

func _process(delta):
	#debut porte de l'appart
	$AnimationPlayer.play("Note mouving")
	#if Tuto == true:
	#_ouvrir_bureau()


func _on_piano_mouse_entered():
	jouer = true;
	print("je peux jouer du piano")

func _unhandled_input(event):
	if event is InputEventMouseButton && jouer == true :
		if event.is_action_pressed("left_click"):
			get_tree().change_scene_to_file("res://Scene/QTE.tscn")
			
	if event is InputEventMouse && $Porte_bureau != null:
		if event.is_action_pressed("left_click"):
			UIbribe +=1
			print("je gagne1")
			_UiUpdate()
			

func _UiUpdate():
	if UIbribe == 1:
		$UI_Bribe.hide()
		$UpdatedSprite1.show()
		var axis = Vector3(0, 1, 0).normalized()
		var rotation_angle = deg_to_rad(90)
		Porte.rotate(axis, rotation_angle)
	if UIbribe == 2:
		$UI_Bribe2.hide()
		$UpdatedSprite2.show()
